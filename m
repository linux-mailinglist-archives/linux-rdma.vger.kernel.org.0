Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF84B7ADACF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjIYPAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYPAt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 11:00:49 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959E101;
        Mon, 25 Sep 2023 08:00:43 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-578a44dfa88so3790993a12.0;
        Mon, 25 Sep 2023 08:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654042; x=1696258842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JkCTDlMMy2k3BxcZSwpMg50epH4WzQdM8qZG/svhWE=;
        b=L5tcDYB26Y1aHCEsTUwhh2+k7S/CygpCgwmUddKQkaysf2dQZi3+Uyfvcfz8zz7ndQ
         muo9jG5chtIb4rxGK3LpLNy6Rl1/WnFT6AdGlSKvUXKCSrvodnEbcY8uNNtNtOkfBcyb
         vznHnDI++TvreSJiY40xNi16jidYCGiN1YqdiX0pevZ9hAQImAwcdly6wnttoAyef/NF
         JglJ+U94yEdt779ULslR6iHsa6zEwxwBT0DS33/0InFkw8IxgxzxtQIlzOFJWUdmZvs6
         KrebUNDZOZnoXL+u9gTI8EC+xRlcM9ypEOJu5UynSHON73dEtGzEluY8yNUFQcqjInyP
         VVpg==
X-Gm-Message-State: AOJu0Yxt6YpIj5C6B2nTW8y7PsGAXRd75tGkoOdcdWXUJ5ja2B0X+D5c
        N7AmwCxdhEWBEsqii1ooATA=
X-Google-Smtp-Source: AGHT+IFYrzQfrJ/MBGu6dXPdgGPJ08jYURmS4dvkUJxpRp9+AS3acQbEqGbu6AD5oW1evgqOE+PSOA==
X-Received: by 2002:a17:90b:4b48:b0:273:e8c0:f9b with SMTP id mi8-20020a17090b4b4800b00273e8c00f9bmr4781184pjb.15.1695654042260;
        Mon, 25 Sep 2023 08:00:42 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0026fa1931f66sm8998771pjg.9.2023.09.25.08.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:00:41 -0700 (PDT)
Message-ID: <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
Date:   Mon, 25 Sep 2023 08:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
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

On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
> As Bob wrote above, nobody has found any logical failure in rxe
> driver.

That's wrong. In case you would not yet have noticed my latest email in
this thread, please take a look at
https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73. 
I think the report in that email is a 100% proof that there is a 
use-after-free issue in the rdma_rxe driver. Use-after-free issues have 
security implications and also can cause data corruption. I propose to 
revert the commit that introduced the rdma_rxe use-after-free unless 
someone comes up with a fix for the rdma_rxe driver.

Bart.
