Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C670609B35
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 09:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJXHVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiJXHU7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 03:20:59 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D943541BC
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 00:20:51 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666596048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJYShCDOeVd8u0XAJUvdvOv3oq9/uVktM0YxjoOiqaY=;
        b=wJILTU4EDTKiqHoDdiIfGMUg8MOLbjKLHdvAxkiCOySHKka2Dy5sVkjuT2MAgRf+a/7cKi
        2LgB5luNBIbdgYnQluEuVtwYXaEFJix6+47CRaDNzEtxhmyB4wiExOU6LL76HfJ4Vsg6e+
        oKOZ7CvgWr0ZrpW2onMB6TFqftR+VdE=
Date:   Mon, 24 Oct 2022 07:20:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <10a79553046a0b9f1942f507fdf97b46@linux.dev>
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Zhu Yanjun" <yanjun.zhu@intel.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
In-Reply-To: <Y1VvxqPNy7bmZ2ZR@unreal>
References: <Y1VvxqPNy7bmZ2ZR@unreal>
 <20221023220450.2287909-1-yanjun.zhu@intel.com> <Y1U7w+6emBqrQnkI@unreal>
 <ac6228a7-52a6-3b80-6b22-c4444b67d360@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 24, 2022 12:45 AM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Sun, Oct 23, 2022 at 09:42:00PM +0800, Yanjun Zhu wrote:=0A> =0A>=
> =E5=9C=A8 2022/10/23 21:04, Leon Romanovsky =E5=86=99=E9=81=93:=0A>> On=
 Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:=0A>>> From: Zhu=
 Yanjun <yanjun.zhu@linux.dev>=0A>>> =0A>>> There are shared and exclusiv=
e modes in RDMA net namespace. After=0A>>> discussion with Leon, the abov=
e modes are compatible with legacy IB=0A>>> device.=0A>>> =0A>>> To the R=
oCE and iWARP devices, the ib devices should be in the same net=0A>>> nam=
espace with the related net devices regardless of in shared or=0A>>> excl=
usive mode.=0A>>> =0A>>> In the first commit, when the net devices are mo=
ved to a new net=0A>>> namespace, the related ib devices are also moved t=
o the same net=0A>>> namespace.=0A>> I think that rdma_dev_net_ops are su=
pposed to handle this.=0A>> =0A>> Yes. rdma_dev_net_ops can move ib devic=
es from one net to another net.=0A>> =0A>> But these functions are called=
 by a netlink command "rdma dev...".=0A> =0A> rdma_dev_net_ops are called=
 when you move netdevice from one netlink to=0A> another.=0A=0ATo "rdma_d=
ev_net_ops are called when you move netdevice from one netlink to another=
.", =0A=0Aif I get you correctly, you mean, when moving net device form o=
ne net namespace to another, rdma_dev_net_ops=0Awill be called.=0A=0Ain f=
act, rdma_dev_net_ops will be called when running the 2 commands "ip netn=
s add ..." and "ip netns del ...".=0A=0A> =0A> However you raised an inte=
resting question if it is correct behaviour to=0A> move IB device after m=
oved netdevice.=0A=0ANow we come back to the original problem, how to mak=
e RoCE ib device work when the ib device and net devices are separated in=
 the 2 different net namespaces?=0A=0AIf you know, please let me know.=0A=
=0ACurrently I keep ib devices and the related net devices in the same ne=
t namespace to make ib devices work. So I made these commits to keep ib d=
evices and the related net devices in the same net namespace automaticall=
y .=0A=0AZhu Yanjun=0A=0A> =0A> I don't know an answer for that.=0A> =0A>=
 Thanks
