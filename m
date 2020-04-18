Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4C1AF5C9
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRXCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:02:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32994 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXCv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:02:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id x77so431781pfc.0;
        Sat, 18 Apr 2020 16:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJ+Kb9lDTE05AAxL1lFRGyURQmZhVp2PRETse/FXtaI=;
        b=ZKfIPSE1UxdpSscWB92uHpGzqLRRNc1dqxvoviBZGfOC4YHApDuKURSIaHBEpTIji4
         J0Tuw9WVFibT/KPOLPhQpLjlXL5YsehUInJ8ImlE9mGJbhhnj7TmO5Un8TF830dfklVL
         09knG3jXRTxeDXNbnkRqskMMVlQWFGrnS4oarLMptgMmWcXvYvpflHhlkeciFgYPFV3Q
         84S4m8X+tM22ejDip7u7unkTGrffrMy40AvBpNSscT5JlwLkVm28q2o77sYGJegfAiyK
         neONlbFWVm+/anRTiNngc5DBKS+0XOceswctpCFmfFfuXQorYjVln9ZFBDIivwQkvbGq
         /Ziw==
X-Gm-Message-State: AGi0Pua/eaoP5kY5vzNdeoV0GJo1OGUaappy77GnHioZRBLuCKJK0fml
        gRgQICTAyhxvIdMRlULDAjw=
X-Google-Smtp-Source: APiQypJydf87C66FeGu/QZMeZQaAgOywlZz96Ho/nwO/wp7fZxABzd6kWKlzMCTx14Ioswoi5iarBQ==
X-Received: by 2002:a63:8948:: with SMTP id v69mr3014476pgd.351.1587250970060;
        Sat, 18 Apr 2020 16:02:50 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id d74sm4860850pfd.70.2020.04.18.16.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:02:49 -0700 (PDT)
Subject: Re: [PATCH v12 16/25] block/rnbd: client: private header with client
 structs and functions
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-17-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5fdaf1c6-1445-79af-9b1f-3c1bd9b9536a@acm.org>
Date:   Sat, 18 Apr 2020 16:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-17-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> This header describes main structs and functions used by rnbd-client
> module, mainly for managing RNBD sessions and mapped block devices,
> creating and destroying sysfs entries.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

