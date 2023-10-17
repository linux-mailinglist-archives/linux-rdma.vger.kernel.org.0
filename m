Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728B7CCDC3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjJQUST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjJQUSI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 16:18:08 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B75BAB;
        Tue, 17 Oct 2023 13:06:48 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-581e92f615fso345641eaf.2;
        Tue, 17 Oct 2023 13:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573208; x=1698178008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2Y4eB55Mqf1W00hoGS6DzogP0Qi0j6/+eiOiIBZq2k=;
        b=hIYbtuFuoWlV+/C2a4KzmlKSq0RaUBEKXLZfAo62wUKrBD2BONGWNuSnxe+RSiD9hP
         aNKhVxdE3eDi7ajEC9UM50N9iMD34tlTwH0j65aVbdazUzfCO6/jxbpin/G+6oePCu4y
         Bv+zG4/tvtACLHXw1qJmtw23cNFu5KD4PzvJoygUEUwnRPZeIu+RyMdF9k/6+sRmvd0l
         RwcttHWDSRPObPBpGOPbiuj829znWMI+E24aq6wy/cb7AQiMThyXI7e3QL5rUyMrF0Wf
         EdQrVdpn5Ju4f6tD2Bh9pMVRCvOFT5bgcQz+TPVTANSUg3ZOqpMT1BYtqyFXospI4DxA
         JGHA==
X-Gm-Message-State: AOJu0YymQ8LgzFtdHBTxeocNqz/NJYfM0tJpj3JHKe0V8JIVB18Bf54F
        LCgQFLTuVq/iu3PxEH7OX/I=
X-Google-Smtp-Source: AGHT+IGTH10nVUoansKaqdnEFZz8OUzTe9o6C2Y48Q8+QUci4dOfqsDlXB3mp3Hf11PYNEXBa7hE5w==
X-Received: by 2002:a05:6358:9da8:b0:135:85ec:a080 with SMTP id d40-20020a0563589da800b0013585eca080mr3552306rwo.32.1697573207945;
        Tue, 17 Oct 2023 13:06:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7948c000000b006b97d5cbb7csm1873852pfk.60.2023.10.17.13.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 13:06:47 -0700 (PDT)
Message-ID: <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
Date:   Tue, 17 Oct 2023 13:06:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
 <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
 <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 12:55, Bob Pearson wrote:
> Well.... the extra tracing did *not* show srp running out of iu's.
> So I converted cq handling to IB_POLL_SOFTIRQ from IB_POLL_DIRECT.
> This required adding a spinlock around list_add(&iu->list, ...) in
> srp_send_done(). The test now runs with all the completions handled
> correctly. But, it still hangs. So a red herring.

iu->list manipulations are protected by ch->lock. See also the
lockdep_assert_held(&ch->lock) statements in the code that does
manipulate this list and that does not grab ch->lock directly.

Thanks,

Bart.
