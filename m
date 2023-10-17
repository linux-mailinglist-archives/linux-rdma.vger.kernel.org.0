Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7E7CC99B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjJQRNg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQRNf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 13:13:35 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD292;
        Tue, 17 Oct 2023 10:13:34 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2874467b3a.1;
        Tue, 17 Oct 2023 10:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562814; x=1698167614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UQtBCWI0mUq1iPPG6xXpwXSSX4/OJ8U4g5nX0UWhc8=;
        b=fNoVZS/uluU0usC4b8VXgKiRyfXTOknWOFRMdwGAXOvlQwvVnBIPG9H38Vl4kQCV8e
         jcPLMeqhvqTEcBazPMmMm0VKYj6rxaqqFWz+2NU/DFkNXo6Tul0Yl2+wvjmeVCuGU+pu
         CjaNablxuDWUBU2X/qkntOtCNbSPsbK0WRhJcqvMRDSqo3U/MSdC5Nb8B3qJEoCXbKqR
         sMBh3DSQGyPhzHuRJs8HdcEzAmws8LvyVUyuEbHWvlw+eB9xHiEocs5HpFqobWg6kH5s
         vys2ZmTeoXy2bhjf5NuRhMD7mn2DzcRU6RjhMCM4NAs0xZlrwzMjwY6cXqjnAjEgIGmt
         Z8fA==
X-Gm-Message-State: AOJu0Yza6d9eFM0Cs5BAjV2SvohQFuxSvxqvj37D8v9LQcdUQohTscZd
        FA2jEpQCF/u02WaJOp5CkQw=
X-Google-Smtp-Source: AGHT+IG76Xla16C3jxxHDhu/0ZnfSrp2EQEEq1V5UaNzZ+7mdzW/cDFCVpRsQJHhp2GD9tgPky8plw==
X-Received: by 2002:a05:6a00:13a1:b0:6b3:80f8:7e91 with SMTP id t33-20020a056a0013a100b006b380f87e91mr4179287pfg.9.1697562813608;
        Tue, 17 Oct 2023 10:13:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79477000000b006bd9422b279sm1697341pfq.54.2023.10.17.10.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:13:33 -0700 (PDT)
Message-ID: <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
Date:   Tue, 17 Oct 2023 10:13:30 -0700
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
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/17/23 10:09, Bob Pearson wrote:
> I don't yet understand the logic of the srp driver to fix this but
> the problem is not in the rxe driver as far as I can tell.
Is there any information available that supports this conclusion? I
think the KASAN output that I shared shows that there is an issue in
the RXE driver.

Thanks,

Bart.

