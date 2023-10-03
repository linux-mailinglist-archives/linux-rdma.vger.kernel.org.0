Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A57B6654
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJCK0A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJCKZ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 06:25:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705E93;
        Tue,  3 Oct 2023 03:25:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso7003175e9.2;
        Tue, 03 Oct 2023 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696328752; x=1696933552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UJbPLQ2sJq+JdJneKcIjpXN6+YXEeaAlp1ihUjhH9nY=;
        b=A7F3bBFdpPsQz7EQyx3/2fObKls0vOph42CX8RNLRUQBTmVcw+tlF/q3XV30rO2I4C
         qstUjIoqORbGcH+JnU7HoaAAlESmt+9t0/hXG5BWACFv7A0yUTHJNtuE+7vxJHkATLmA
         6o2heFj0DWure4XXSPqVy7YFhze1Zeb4HaBj/31JzF3BsW4YxH12tawI52YtHNhJcLhd
         TMxecwej8EpO1cqsm41nTeU8bQk4AmiN+uewWyFG016DsGEI4tGtg66g+d9ikEluF9Eq
         /rb3QRt3vH9T3yb9Nqtlvx7G5cBXvTVb7M6rMPyLCr9cVTL5GjNWw0aIW8n4s1hsopzF
         kAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328752; x=1696933552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJbPLQ2sJq+JdJneKcIjpXN6+YXEeaAlp1ihUjhH9nY=;
        b=XeyftuBb66/Sn3YhC13i9f+DgS3l97EqZs5cNCVbFRMCLtn81kY/8FHS9yUCNKcy9T
         I6pjcwUOJHFMItGxG0fYn5NQ/4OLCUjs9PRPMBZdmmlbiHs7Z2+UQiHpwHMognTuP2SL
         tkgs9W2FAnACVE3gSC6HD7sZVP2qsg/NPtlThAbIkwFPKYQo3ayVLSPd0a+6+jgZz7mE
         NT5lBV1h+xPGQd3t74cxwkxdaez/UCH2x2l15Q/HbTmS3Gp0jFHAxXoCnzflDlMyYokC
         jKp/l/THKIlzGDtOEdovrVTKjnKfAGN91yRVjhggZAsE47UtgdpuWwkiA6lkFHNAgGD3
         Z6Jg==
X-Gm-Message-State: AOJu0YwFzrLWKiYk/5rsONKK0kiHW59T5VYVrz3CqPYowPyagqa5NGeJ
        1521Tmn3jKUcEcIPAAuV1w0=
X-Google-Smtp-Source: AGHT+IH4PtfHldj0VvMZI/On+6s7VpV7CIQtUMLRVRfnUnG2AW04zeibvBdNxyG/QoznL6yrZAPK7w==
X-Received: by 2002:a1c:7c0b:0:b0:405:3885:490a with SMTP id x11-20020a1c7c0b000000b004053885490amr12474883wmc.0.1696328751231;
        Tue, 03 Oct 2023 03:25:51 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b004063cced50bsm945150wmi.23.2023.10.03.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:25:50 -0700 (PDT)
Message-ID: <651bec2e.050a0220.f5ddb.3810@mx.google.com>
X-Google-Original-Message-ID: <ZRvsKwrdSOI43YWZ@Ansuel-xps.>
Date:   Tue, 3 Oct 2023 12:25:47 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Snook <chris.snook@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Dany Madden <danymadden@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Wei Fang <wei.fang@nxp.com>, Alex Elder <elder@linaro.org>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Bailey Forrest <bcf@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Junfeng Guo <junfeng.guo@intel.com>,
        Ziwei Xiao <ziweixiao@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rushil Gupta <rushilg@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee@kernel.org>, Dawei Li <set_pte_at@outlook.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 2/4] netdev: make napi_schedule return bool on
 NAPI successful schedule
References: <20231002151023.4054-1-ansuelsmth@gmail.com>
 <20231002151023.4054-2-ansuelsmth@gmail.com>
 <CANn89i+eSWYuE=wE1TPJFtAS1OCfFYytC_nAjDWkizxmR9e6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+eSWYuE=wE1TPJFtAS1OCfFYytC_nAjDWkizxmR9e6JQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 03, 2023 at 07:21:46AM +0200, Eric Dumazet wrote:
> On Mon, Oct 2, 2023 at 5:10 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Change napi_schedule to return a bool on NAPI successful schedule. This
> > might be useful for some driver to do additional step after a NAPI ahs
> 
> This might be useful for some drivers to do additional steps after a
> NAPI has been scheduled.
> 
> > been scheduled.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Yeah, I guess you forgot to mention I suggested this patch ...
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Yes sorry, totally forgot to add this here. I already have the patch for the
other driver (but it's dependant on this so I'm waiting) and I forgot to
add the tag also for this piece.

-- 
	Ansuel
