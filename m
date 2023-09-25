Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADE7ADC58
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjIYPwc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjIYPwb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 11:52:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D8CE
        for <linux-rdma@vger.kernel.org>; Mon, 25 Sep 2023 08:52:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84f18e908aso7269715276.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Sep 2023 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695657143; x=1696261943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Koh5rkh3Eo1xWzvMCWLKBrOvFS2mu6zjkbegt/AyKE=;
        b=aZUwOV6ILDwosSLLNPn0Wp/REoXpPKAdcq+1gSFK3fNaPKeIZkEBZSHCEMyl4wd8iE
         BSqWxye3HM/jAOJ4L7BV1BCP9u0EhmyDIvbI6HsXxpohA8O69OzdgutVYuyLlXs1CuC2
         ZuM65yaeSJrK5ShTW9ZKzApOLfPAvJW1swLq/V9M/AY5XMhWIR8Qo2lS768ycNLdMxS8
         4Qj1Om95k1/LO0hGaq25WYkpxov+YEwYJJ56vai1nf0tKmUXR0vHmd8WclDdGLqcBAQB
         Ka5v07IJBOIbfWbpT53S/uHMZE6ipZR/g1Si/2k5vVTaVByFE9EAT7YeWYa3vSQhXmlt
         Vxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657143; x=1696261943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Koh5rkh3Eo1xWzvMCWLKBrOvFS2mu6zjkbegt/AyKE=;
        b=YM3nYf2m9XAMv//0fE/eHwnxCQUeae713RaiOtlWg26QYeiYh/ufMj9jO+/DJDabbn
         yvt1ZfyussbEW571ALkpKaekXw1mNPR3g64W9GcOtH1grUxzkxgbaV2LYLwan6RHIICb
         1mQDeDZH1IHrZk9PHITf8Z9yCn0mtX6Wc3LeEXVVgceoboyBxnud1rtKXT+MguVTgZ9H
         14J/EpuFzpN5GhqK5aux+rhcbh37f8veu90GJUGEpQSe/P0EjlNXKE/AUExn/j4Ki65L
         tXcxG2LiUlU4pwvZfgedyz0zy4MCEV0ySRqgLWx56BYChTMZlhngVcHWRdymzaB5jBGx
         2LZg==
X-Gm-Message-State: AOJu0YythALbEp90y0rwLUiOPMQUvOLDeEw33/qxWdxAJ7cgpxKjX24C
        AwIwQjdMrRIHCIW4Fo9HSYXD1A==
X-Google-Smtp-Source: AGHT+IETMJJ3Syd+giRYotIiH58lI08Wnu0bG0v+wTl03Z79gY+ToIJxWQcTE2nT7ZCSEubke6DUig==
X-Received: by 2002:a25:4683:0:b0:d71:8e8c:5233 with SMTP id t125-20020a254683000000b00d718e8c5233mr5926005yba.12.1695657143361;
        Mon, 25 Sep 2023 08:52:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cb3c2000000b0065b08bb01b1sm1329874qvf.60.2023.09.25.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:52:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qknsk-0012CO-73;
        Mon, 25 Sep 2023 12:52:22 -0300
Date:   Mon, 25 Sep 2023 12:52:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Message-ID: <20230925155222.GL13795@ziepe.ca>
References: <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 25, 2023 at 08:00:39AM -0700, Bart Van Assche wrote:
> On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
> > As Bob wrote above, nobody has found any logical failure in rxe
> > driver.
> 
> That's wrong. In case you would not yet have noticed my latest email in
> this thread, please take a look at
> https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73.
> I think the report in that email is a 100% proof that there is a
> use-after-free issue in the rdma_rxe driver. Use-after-free issues have
> security implications and also can cause data corruption. I propose to
> revert the commit that introduced the rdma_rxe use-after-free unless someone
> comes up with a fix for the rdma_rxe driver.

I should say I'm not keen on reverting improvements to rxe. This stuff
needs to happen eventually. Let's please try hard to fix it.

Jason
