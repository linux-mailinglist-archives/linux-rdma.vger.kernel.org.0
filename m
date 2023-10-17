Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364597CC9F8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJQRel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQRek (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 13:34:40 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479C98;
        Tue, 17 Oct 2023 10:34:39 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ca6809fb8aso16579355ad.1;
        Tue, 17 Oct 2023 10:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564078; x=1698168878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+po5fuuGVBm8yXagURHbcZax/69bpB9Mp2v3QQyGFaI=;
        b=QkcMeeF0OJU7XrfC4PWypwKrNBgXP/RdWMeEmCpWVeWRqXt79yc/7t8epC8AfK8Cf4
         RqoKV0kVuF4jIfoGsup86lsK+lsVF9dFqKtl70BzWj4aYqhpyaoBIgUqSXaV+FY8bFh2
         QJAUt4lEF9Y27X7NSwFr1zCtZrJzrDjs4ADoVbPiRRmzmMNdzVa+6kzlXL0q84uTqaAu
         ZdrFT+pdOI/Qo8ecdfSdHXiVcrA2NInAiNKJA3gfOCpEDVw+BcWkq7LA4RtjTLLs/b88
         gO+iqdhFUpvcZgq85/Zu59vp/RUYJoK+XcrWuT9Yj4IPE3I2ubZJob2Zgdpn/gFiYAPz
         sgtw==
X-Gm-Message-State: AOJu0YyRnTQ+/b34T/DOug3JabROR3GesNPjNZpUKcZknp/iV8AZDreK
        afQv6MDLnW/SmU2y1scMF7h83Rab+Ok=
X-Google-Smtp-Source: AGHT+IFysUqKZxxLtjPFmjwtqLi8/yDXHDKrH9D5OkqUSrKoHJ46GpLagI5zHnvxRm4Ywbd3xcJrjw==
X-Received: by 2002:a17:903:18e:b0:1c0:9d6f:9d28 with SMTP id z14-20020a170903018e00b001c09d6f9d28mr3354358plg.11.1697564078454;
        Tue, 17 Oct 2023 10:34:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001c55db80b14sm1843650plx.221.2023.10.17.10.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:34:38 -0700 (PDT)
Message-ID: <ba3a69a2-4756-495d-a112-c143930bcbce@acm.org>
Date:   Tue, 17 Oct 2023 10:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
 <11acd7e3-6a56-444d-827a-e06f00589b9c@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <11acd7e3-6a56-444d-827a-e06f00589b9c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 10:19, Bob Pearson wrote:
> Should have mentioned that the last set of tests in srp/002 have much longer
> writes than the earlier ones which require a lot more processing and thus
> time. My belief is that the completion logic in srp is faulty but works if
> the underlying transport is fast but not if it is slow.

There are no known issues in the SRP driver. If there would be any
issues in that driver, I think these would also show up in tests with
the siw (Soft-iWARP) driver.

Bart.

