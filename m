Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672254FB0F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383301AbiFQQ37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383300AbiFQQ36 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 12:29:58 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B942A0C;
        Fri, 17 Jun 2022 09:29:58 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso4586976pjh.4;
        Fri, 17 Jun 2022 09:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1CdPsYcJMiRyRao0OFv69oSt2+3EiKlT7x2/BM9HIJY=;
        b=wLXdHre4Ceoa7M466IhIXfn5jrZ4LP/it/CFC1T/kC158ldBbMa0XHUPU1Ui3nx30q
         zIbMsqXjn7q65AmCHto7DfvTWi6rrZlM1JOFSjP1q6D7+vxho2NVX1Nsv46q3uE1P/jm
         KjG6IlvmLh9b+WHwWElL7zqM7Pmi3IYJWtG7yVGDw49en2/HxC9tN9uBGJ1w3zG1Mp5e
         rWv/q7dj3KoMG9OZf8D6326gscoaYpjYbBgbb9DY/v+ql59tOSeoXCzmxpiJP6X2fQtL
         ONL5ic9UHCCdrKFexP2scZizqZEqhzXPGbLWC7xpFf1uudP2Wc8DeqboWVHJKGqJB/jc
         BjIQ==
X-Gm-Message-State: AJIora+g7fiM2nLNBMpQErm8+tyxYrxCfS79iIJdhVqyYA/m9sEA4e1O
        ioOkuHU0qRyN/trW5E69t4M=
X-Google-Smtp-Source: AGRyM1t/wDXMzo+bOEkKIQH/k9xjz21/990h5UWigbcfj8KAhJoJx1iRoTgXlJGSllOagISeEk0Fkg==
X-Received: by 2002:a17:90a:6444:b0:1ea:b662:c12e with SMTP id y4-20020a17090a644400b001eab662c12emr11580102pjm.199.1655483397636;
        Fri, 17 Jun 2022 09:29:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b0015e8d4eb25bsm3756460plb.165.2022.06.17.09.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:29:56 -0700 (PDT)
Message-ID: <336492df-d74d-9eb9-4b51-d6d1f915493a@acm.org>
Date:   Fri, 17 Jun 2022 09:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
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
 <1655463320-241202-5-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
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
> The SCSI core code does not support reserved requests, so drop the
> handling in fnic_pending_aborts_iter().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
