Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125155CF4D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiF0Qhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiF0Qh0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 12:37:26 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D56120AA;
        Mon, 27 Jun 2022 09:37:24 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso10555760pjz.0;
        Mon, 27 Jun 2022 09:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h+CBkZaCUAPsWCF3WoXppHNKCyy0dZJN6jYn++00T3g=;
        b=7p1fFtmxjpgpdCxfjBHM1/VvTSG6Lpy9043NJpMYFZvwJzsJKlyeMseOTDj9+yFtBO
         XP8VxNnsyciE6/OHjDc3RAd81A9hgwmtxesSC4opzbmEV9lJmPwSHWxvyNXSK8/9ntIv
         8T15ZK1PnGHKIaW48WErH/47wJRY8itJXSxsDCC1VDpHcuS3ovEuvnO/i+7dlclnAa5k
         D9W2ds7N4JRSTbOgdxCjCgW9rPEgI7ew+a7pooShyhtFixgNmJrVOCjR27Iha1SUGGXR
         xJv+HfCOdoYqcBrLj1lJl5qEnlSY1TVx9L53ibCszzCShfZYqJ6Xc2B8x/FdAqZt/9K1
         4CFA==
X-Gm-Message-State: AJIora98faboZt6EoG9xTun9oAE15ZN3Zn5yWNpmiQ9BQ+7BscbWGnxi
        FfvNNhEUr+B0DwEUrDoA/PE=
X-Google-Smtp-Source: AGRyM1uxX09PPBW2F2Ve5hEmUYge6i2EYx09NheABWO/DbMTHVZ8M4EiHWU/Ay5mZjKCh3PMVRT2OQ==
X-Received: by 2002:a17:902:d4c8:b0:16a:480b:b79c with SMTP id o8-20020a170902d4c800b0016a480bb79cmr235609plg.15.1656347843352;
        Mon, 27 Jun 2022 09:37:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebc3:3a94:fe74:44f0? ([2620:15c:211:201:ebc3:3a94:fe74:44f0])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0051b693baadcsm7559184pff.205.2022.06.27.09.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 09:37:22 -0700 (PDT)
Message-ID: <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
Date:   Mon, 27 Jun 2022 09:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
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

On 6/27/22 00:09, lizhijian@fujitsu.com wrote:
> So far, I doubt if the previous defect of configfs mentioned in
> 9b64f7d0b: "(RDMA/srpt: Postpone HCA removal until after configfs
> directory removal)" has got a better solution. if not, i have no a
> clear mechanism to avoid it yet.
> 
> feedbacks are very welcome.
Mike, are you perhaps aware of any plans to add functions to the LIO 
core for removing tpg and wwn objects?

Thanks,

Bart.
