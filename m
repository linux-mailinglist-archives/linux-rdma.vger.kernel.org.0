Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7723CDCC54
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408773AbfJRRKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 13:10:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42169 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406050AbfJRRKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 13:10:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so4260032pff.9
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 10:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aj35VCMbx89QuAm5WaSE84BkyrGFDS7pEc42puagD4Y=;
        b=N+nCOtRYxea+YfRNG7flux1snNoyaLmD6Z29IrGRPX8WQSHejGw2Sj7v3MXsBoHAw9
         KOV3kL77/t0r5+BUTWuOrtr88b5XAn1M7z/HENpjk+bFcc4pMfBAT48M0DGgrLLDLPTj
         ewx1pt/qqkLYBoBvAyO0DFw4CmJiT6JqxnbGETt0rkoMDZfz08iulEAhuVviiCQpFlRO
         5VP7rx2aLGuvo8QcjYL01mCMdZsHWs6YbETou2t/scMUFYsG9coNV8SaRiOCsgFY/JHu
         bSr5TuL6ucI7jNhNEqcCT2h/wcaYJL0lkMgp91NGxYzeG594P1dtErWoxK/s5WLr+L5H
         +1lQ==
X-Gm-Message-State: APjAAAW4nhsOD2q0eZCYh2L2Z/JzZMG8PrqW1Kw20Miyi7SVyhYRaDCv
        ew9cxTz1JlMrX7vp5jjWZ2y71vw2
X-Google-Smtp-Source: APXvYqyJq46pRiPt1XToNdSEL6DLajNSPeQyAZ5H00H9dn+CQays58+QYn/Y0DdQK/jJiRtwpRpYfg==
X-Received: by 2002:aa7:8583:: with SMTP id w3mr145376pfn.129.1571418607110;
        Fri, 18 Oct 2019 10:10:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r30sm7210733pfl.42.2019.10.18.10.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 10:10:06 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
Date:   Fri, 18 Oct 2019 10:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/19 8:22 AM, Honggang LI wrote:
> [ ... ]

Hi Honggang,

The approach of your patch seems suboptimal to me. I think it would be 
cumbersome for users to have to modify the srp_daemon_port@.service file 
to suppress a kernel warning or to pass the max_it_iu_size parameter 
during login.

Had you noticed that the SRP initiator stops parsing parameters if it 
encounters an unrecognized parameter?

 From ib_srp.c, function srp_parse_options():

	default:
		pr_warn("unknown parameter or missing value '%s' in"
			" target creation request\n", p);
			goto out;
		}

The "goto out" breaks out of the while loop that parses options. We 
cannot change this behavior in existing versions of the SRP initiator 
kernel driver. In other words, if the max_it_iu_size parameter is not 
specified at the very end of the login string it will cause some login 
parameters to be ignored.

I think we should use one of the following two approaches:
* Not add a new command-line option to srp_daemon and add the
   max_it_iu_size at the very end of the login string.
* Modify the ib_srp driver such that it exports the login parameters
   through sysfs. Modify srp_daemon such that it only specifies the
   max_it_iu_size parameter if it finds that parameter in the list of
   supported parameters.

Thanks,

Bart.
