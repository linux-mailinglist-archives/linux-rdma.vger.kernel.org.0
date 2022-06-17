Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5654FB01
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382500AbiFQQZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFQQZ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 12:25:27 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DD338B4;
        Fri, 17 Jun 2022 09:25:26 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id f16so3326557pjj.1;
        Fri, 17 Jun 2022 09:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qffc/qF45xQUUVX0iLvakRS+0SCnFCY/1DsKCxCMUk4=;
        b=p6Luqnnjif7dM7tiFpvHnZDRHy4vfN3T7EjNUaBXKKxZ4iQN+PI5xS+Aov8+r2BDod
         HfNmaU8PGs5CAFc/rpH4pyBYMIFrbA40iP1SnI9ddt9LxgJzo/0NRFZVurShJWjoh3fg
         Wmt+cWydThX3eUieFFYVoVlcW8Hj/53z9E99MQ/dvjXeKkRmEZauVREz0REYCXzO6oUn
         HPVqlyVvgbYi1xuTkCxHKU/WUKMtulZe7aHSxxB0NReTETXWcHfV/h6MDcwpiPARM4a6
         PoYY7lmssBxz5Vd4edo5UEpngReKNhU5BuspY4nxHCVHzkherTk/7lwTYbxZqG1JUvsA
         iYbw==
X-Gm-Message-State: AJIora+M6P7NP6ojzH8mXN0lHA8DVyq1V3CwwPMIKIJrCBReCF2/vfQH
        Jtp1tb56UExiAiO+bgsm81Y=
X-Google-Smtp-Source: AGRyM1v0wKaWpD+fRkQWYGcTmSFjnZvqVDvDVjWy1Fw5laZHlNFrGY0kvjKc1A9gYn6s9UIarDHnZg==
X-Received: by 2002:a17:90b:1b49:b0:1e6:a23:69c6 with SMTP id nv9-20020a17090b1b4900b001e60a2369c6mr11379208pjb.124.1655483125778;
        Fri, 17 Jun 2022 09:25:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001637529493esm3804323plk.66.2022.06.17.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:25:24 -0700 (PDT)
Message-ID: <f559b5d3-cba4-4dff-7db0-5dc24b4078b8@acm.org>
Date:   Fri, 17 Jun 2022 09:25:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/5] scsi: core: Remove reserved request time-out handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-2-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/22 03:55, John Garry wrote:
> The SCSI code does not currently support reserved commands. As such,
> requests which time-out would never be reserved, and scsi_timeout()
> 'reserved' arg should never be set.
> 
> Remove handling for reserved requests and drop wrapper scsi_timeout() as
> it now just calls scsi_times_out() always.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
