Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29827557C97
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jun 2022 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiFWNLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiFWNLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 09:11:02 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E22E9DC;
        Thu, 23 Jun 2022 06:11:01 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id n10so796517plp.0;
        Thu, 23 Jun 2022 06:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=68nt+J0G/haWsaqcORubs5/O2GXyfdJNdDR4QR4VCKw=;
        b=OOXLkug51HBqCw3dNk3pSEFynWE9ri2JWFspSvWJxb/TckhcRf012zC2sGXlgNEuFU
         cR+1wwiAFMsh5uoVp+5JcbylySNFJdgqrA3t5V21Wk7QnHD4Nu6kXrBI5fbhYl80+iof
         dCZAs1StpH0Y8xwSxqsDpK5cv7ddaJGi98rnb0zlF6Fh7NdcVVe3l6dfdZo48yUXJE6Y
         oeNu9w1r3v6tKeYjxWHa9AiY3QwG4vX59YIS7CpNUiotR7SWPrwf6GCMmXnDdeZJI9+R
         aBFDJQPWHbf5AngdMelmJKIGt9A7B2kjwxo0KjKAtpLP8B5g5RYMjR30Af9zeBKiReMW
         Yb/g==
X-Gm-Message-State: AJIora/2q4cP3au2rrc4u+5JfrNd+l86AiuiDyMxAWp/Um9eTW2XE7Ed
        gR/fNuEEbxBN5Ftr5ewfeNo=
X-Google-Smtp-Source: AGRyM1ug8aOaBKwK2eQ4pDHsrijU8aBX0RbI1irUvRXGrh/3bVzmBklJ17kBxFIfIHeCUSDk8qqjYg==
X-Received: by 2002:a17:90b:4c8a:b0:1e3:60f:58c3 with SMTP id my10-20020a17090b4c8a00b001e3060f58c3mr4043995pjb.230.1655989860307;
        Thu, 23 Jun 2022 06:11:00 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id jf12-20020a170903268c00b0016a0ac06424sm11978240plb.51.2022.06.23.06.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:10:59 -0700 (PDT)
Message-ID: <3a2a2d1a-ab52-687d-d521-4a05d7047701@acm.org>
Date:   Thu, 23 Jun 2022 06:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] blk-mq: Drop local variable for reserved tag
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
 <1655810143-67784-7-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655810143-67784-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/21/22 04:15, John Garry wrote:
> The local variable is now only referenced once so drop it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

