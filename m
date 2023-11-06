Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F47E2669
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjKFOOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 09:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjKFOOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 09:14:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF9BB
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 06:13:58 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d093265dfso27923966d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699280037; x=1699884837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDU0wWublCHwErD/uuzhUqo+KV+blLjlv+eXO3Npbqk=;
        b=A1YbmIerIIAa0DAmERk1P5FBbTIVCHyMCwvzPtte7ucJs9VVQZJ05NfwBuEw7E4myA
         RyStFr1jpzJRf1hhhlYQaquSN1fT6UawbO1zSFg4oepTuC+davv6KcE9lhy3bmKrUBId
         xDIMZHl1izlNZxD8ojegNhpF4AfAh7gCyyRuGblzKAtw5vTlRuoNh7K/KwYLq893IGtO
         ws33bdF3NMykViYcQ1porGUUXHU1Rm2fwj0nd0UrVGqPxam3OWh6M8aEOy98p6xtbnQm
         brYTOgUY+bTNzRsmF6zXY9OvojZPDm0LUN9zY+wJxS+iXoE9YdYO2t6riKyqTGg/2Y35
         j74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280037; x=1699884837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDU0wWublCHwErD/uuzhUqo+KV+blLjlv+eXO3Npbqk=;
        b=r2/CDMlrSZCOuiDnE074cgCbt0Ye6bvr7kDZxxWWR195xGjl/8S0Jzj3kbAUM8QW2/
         GsFKWSaylD8gGFkG4D9YYH9eN4vve0fQ93pRlTor4NMf2z6sXHSSrv1KS4LoaYt5AMLU
         /E0EmAdGsgaFK7ohNRANZ3Q/Mr5eB6hQZLjCuPZuDc3zJtvTQXateshebZAcPN7SaNv1
         KUP2nMB9oqgOTCAwY0IQYcC2ttC4LWrwp2lv7kp+q0+JetKNcKJ5BBONXIMKGqZ9ls5C
         TWl3hNcg5JSrMmChb+gszdmuTlbuzm6ukWMVBSBSDCOwpsQH7bJp+kMqWMoLN1Kk/RMO
         4nSQ==
X-Gm-Message-State: AOJu0YyJYfLnI5hj/2rboR+l0fiNxKHQ1oCInzoAdQ8qaIXIvPWAbDKf
        QaR1rTvLKUUjBMZbBQk5QmMujw==
X-Google-Smtp-Source: AGHT+IFdy0cLRV0swElcs4VrROruCPWP//AdITEbdJ/n86FFy9jEHbi0Osxr6jj4PapRo+3Y4duHsA==
X-Received: by 2002:a05:6214:2402:b0:671:1d0:d758 with SMTP id fv2-20020a056214240200b0067101d0d758mr38263789qvb.17.1699280036758;
        Mon, 06 Nov 2023 06:13:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id l6-20020ad44246000000b00671b009412asm3424509qvq.141.2023.11.06.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:13:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r00MU-001Ns5-HO;
        Mon, 06 Nov 2023 10:13:54 -0400
Date:   Mon, 6 Nov 2023 10:13:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Message-ID: <20231106141354.GK4634@ziepe.ca>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
 <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 06, 2023 at 04:07:19AM +0000, Zhijian Li (Fujitsu) wrote:

> I'm sorry i'm not familiar with the linux MM subsystem. It seem it's safe/correct to access
> address/memory across pages start from the return of
> kmap_loca_page(page).

kmap_local_page() gives you a PAGE_SIZE window only

Jason
