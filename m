Return-Path: <linux-rdma+bounces-7356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D6A25882
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A61163EA9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DA20409A;
	Mon,  3 Feb 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b="MJ4kdhY2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic310-13.consmr.mail.bf2.yahoo.com (sonic310-13.consmr.mail.bf2.yahoo.com [74.6.135.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C7204096
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583410; cv=none; b=qHSy5AU+1W/E/fghReIUKLtmqHRf59tPjzW/fw0ir/7L/qfk4ieURtsT+04tkQ1wkVS+pEfmv7FZfqdhsa/LHSR7nmEH4PBbN3eToxMPUylVnAGONkQlb/oBCYB2bhCEYbJ8IasB0wuYWQMxELKa5SPRBibm3QjqhH2RV4M5yL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583410; c=relaxed/simple;
	bh=L1vF05Hdm4ePH/hMIJopirb0DJmyhajLBsXV56rCnR8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ObIi7F26pQCzOiuHZRGXO6Pa2diY3JTguOM1lLMyZXLowJSS/QN6cb7MjIVRQq+WhrH3VnfREhnFj3LhSO5aPFEmwS+StotjbAYevi9nh0hTPGw18czP6wjRU37Rn6DKay+Yr6tewld1e+gBVKSi7jQ+VRhI6rriNiVcDhSou+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com; spf=pass smtp.mailfrom=ymail.com; dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b=MJ4kdhY2; arc=none smtp.client-ip=74.6.135.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1738583402; bh=L1vF05Hdm4ePH/hMIJopirb0DJmyhajLBsXV56rCnR8=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=MJ4kdhY2SuE4uj7J/TcPz7NgokJi0qvJAMW4KMl1E7KtbGmbHQ7D7wPeoVDEW4dqCOdPXFnzxO3e3Qyx9J3MvPXtHEeZ74kSVdxpadUNivI8LhPpSBrRFVRjH4MYWJNE4BICC89JqG9KxE2LaJ5NoBdtcdqzKMeSm3bdQh20kRDF4bOJcnHjbvPSV+Ob5TgBTx8hRnpf9rADMJ3yHwokNRuXS6Suk9CCQSzKwnFyaDfeiS4EsD9gTalzz8IBiNvzPkvgEp/2HP5VkLE/CKK0kvrYRvAFGUZrsSWRhf1gbhdX6SRwSGTf12cil9LcD7yZhHGNVJrsUMXBaRRYLVwh+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738583402; bh=8Gqn/gbQhyz72rnJAo+D/4IacwpJGqxpcuDhwdmpipr=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=fgN8C2EOXHk1c/5cN95g/vrTe3GNYtQA3TYIEwe0mxE82cSdoeH1TEVsKmikaQml0N/VA7xSZvrS/BOztTvMJAKeS5uTWjZy+NjYfj4Qzvf3qWtpcoCgdEF8Tucnug9tmus2SsA/9s1liHEULwYjYu5mVkbQL4cMyGCt6S0kk602kSUtPM3ckIZp+YbUIxxRlr6gxzsDojYlw8eYjB8QCj7E5cZLxEcWRwHDWWmkkIzklj468PIOPsdHJJ50jHkrBobCTGDP2o7HpgG/Ha3gIPVpj0vbAEep06wfX8lmZ4W47oQrQTc0F2Uv/VFHYCWL5ijOaSrhlQTO1YnnIufsiA==
X-YMail-OSG: HNiBVEMVM1nxwTi6SJeec48YcOEVMhG8qbMSFmatiMmFCjQnk7RInoS_Y1nW3ik
 yxhr6lDvmdY.med2OGhqdi2SAl3mMLlcD3_8qIUE56ch6bnUpasyk.oC.YiOEbvs2S2sI2b6jrq2
 Bu8CEu7YXuAjE85kOArR4iKbgucRj.b.Jcb2uk6NcWfKiVuVDfDPBj7xU6GSURd1F4quLAmtmqNE
 qqqH1L4ITRk.2e.wI_rS50eBO13d47S35V5R9qarC2o7I6YR.1OOGONVw7MbtUhKaO5vSKok2BPP
 2hu2Bfg.B0bWAY5oBJmsvvmEs9boq3F6T_rDxqTjvcRUimBELvNKELha9BL9WFGkP7kyP9ocZYBF
 ve7e5ohgUzxnkQFkLVqULcpajI9UWi008x1zupsrp0GxrOTyqqdLbXNJFTGdKhjM58fB8Nv57SpR
 PZlOZ1VRSXIylYyPZRv_8nZKi.kbDIeEWUnmLl0hY.2DsB_i3yDwr8ykFmS4kQC.93.JWcajVwRP
 .Inpk8H_E4X0foPtmbNNEzX_4PY2U9hnlrKQ.XsKIlys39burC3ydjKDzwv9_CSgViDkudwGBilq
 18ORdk7LXpjd0LKIlbMPzoKWEHxVz3ZD17QnSJWZntdTm.IXpRNTighOXNn4o.UdzbPOrvS3hwhB
 QiE.FPRDXqzBEObpzeJVqsNQ1HP92aqguB3Nhz4.VIOIbfN0Bjp7SxnDJ_20_oJvp2x1mjNwtfeu
 exV8aYG7V9SCihdKlHmC3pnFaf7aFLWAdQrQB4RSkEaBGDsRxHaEBcCvHOkm3CXa8cwHt9ppp10r
 qVp9qlHcppUm86aERq9hkEDnp71sAstMf9PojFpgXP6Su7tWfeFVGc60EtvvRmtEDF1N23k4deZG
 K__DtPdRDi9DmP2aNsEkqG0BMwedlXJKBTMdDf_LzNp2wKv0kpadcWWmzXQYxx.JKzrXs8vdy_g9
 ljUXhUwz8GAorfE0aFUha9tmlavBcE_IKpOlbDBQykjYNlLfrxN0UrvvGJMijFsYsyLWexLuvAH.
 UdZMTn8rgqa8WckoR8Rjz4trAJpZXk_58J3eXLfFlcA_r2Rb4ldgyiDzboGWL9CDH8JZ_n.jTaoJ
 mKezG.tOB2685bln4rmL7JNUwEjmLuXVqT_gpgqSuYDIOPbWNN..K49XgO87XkZ1b2QWDiGghI61
 ZnP7HZ5BhJpUw92WtdBdmKAVhWN6lvOR3CZpOrPclyVH7avJ3V012pvNPN0BCtlwfEHIBwbJodtA
 MkHlp6jErfvGRdFcsvJoeCYBrHjz0AfmPmZWsNJTa9MQDOIO8WuO8VSaam6G.kvfah4VGOEEGeVA
 .iyTI.vZ_o8DUySn2339A17bg1OrYFGprjIlkgMMOBQ5pqlBlZPfdLebJhYKltw1BuaLS7EU59qv
 drv_WZ9jx6TgGpqirsnEO00y.RPP4hw8uWKFgNaHGF0Yxh77OT3qoolIU6P.RVEEhvCfmbg_MYzV
 mh7Wqd3nMVJwr_gokjaGcRxDwh3Muyqn93oECmNuwdOJc.HFVte1roDopu.m6rao11qDQ3MpPCGb
 jGG4AoTco_0MoaHnFiGW8ROMB8_a.HuNy5fuw8mf3VKiOkPP2i6TEpvHTrZjJKSrVu3cDH8BRKFk
 9SxFTFEiiAvVaqpRQbEIFsz13W3rAJbi9p2cIspalWRuut9WE8YexJoQmE_.wzxeGMEM.hflnLOE
 LJvtbvWEt09ik0eB438B_i2OQF6BRtg0SO7ZZ2jHu5CipUR1nKsmdppXXdewn437UEs63tg0W_dY
 O6H7d1GVagFBcx7rET4u3KvjCvkrv8jruzRzG87uoSDzIjILKR5_ZHNDNbSab6DYCMzwLqehxMww
 CkUJpIW7wcQ5MwuZdKvgxIoHQO7nmUN4Pvcd9IVR0ONdKVB4DAySl8TuybzxE3luA05BXhW.Oypp
 cn2oS6uE8yakp6jZebcgQRhyCjzpLtlqw1aQPw0wTelhhI5H3aIbBv7iwXg67Q33z0VpPMyn6KxI
 QJOfxIefaWBjmO5skLyU4vn7wc0cQNzapk7LUW3Ulszlv94tiiLVfczeG4YB5JAsYqdqLP_dxlls
 iwptCWeJEsexRrUOG7Z_d2FXtLoPNPp4OCBMXkRu5fUTCaKUSVvzPh3Qvmbpd7kLGqcJkCYUpkab
 Q12iLYtVGAuvt.louC29f5Tc7srgQGuEP6fr5s_B5.t1e8_nIiAWZepfm_SU0_.CogC3GFMy3qBI
 HgZ.qX9Y1UHZc4LR99Q4KspbnnKGAWobmbwo9LYR3sjTC2WGoATznXGxRb3Xr
X-Sonic-MF: <andrei_ss@ymail.com>
X-Sonic-ID: f6bd2b3d-2538-4694-9e92-c6b17ad452e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Feb 2025 11:50:02 +0000
Date: Mon, 3 Feb 2025 11:49:59 +0000 (UTC)
From: "Andrei S." <andrei_ss@ymail.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <1987018723.4199950.1738583399344@mail.yahoo.com>
In-Reply-To: <1820967876.3499649.1738253436582@mail.yahoo.com>
References: <614323370.3481698.1738248482448.ref@mail.yahoo.com> <614323370.3481698.1738248482448@mail.yahoo.com> <606461795.3488473.1738250979711@mail.yahoo.com> <963276744.3495268.1738252591349@mail.yahoo.com> <1820967876.3499649.1738253436582@mail.yahoo.com>
Subject: RDMA over IPv6 between 2 NICS on the same host is not working
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23187 YMailNorrin

Hello,

I've resent the mail with correct subject.

I've noticed that RDMA doesn't work on IPv6 between 2 NIC on the same host.
I've tested with rping and=C2=A0ibv_rc_pingpong. Below you can find the com=
mands and the behavior for each app.

rping test:=C2=A0

> rping -s -a 2001:db8:153:1::10 -p 60009 -V -d=C2=A0// waits for a connect=
ion
> rping -c -a 2001:db8:153:1::10 -I 2001:db8:171:2::20 -p 60009 -V -d=C2=A0=
//=C2=A0client waits indefinitely to connect to server

ibv_rc_pingpong test:

> ibv_rc_pingpong -d mlx5_2 -g 5 // waits for a connection
> ibv_rc_pingpong -d mlx5_3 -g 5 <IPv4 address>=C2=A0 //client throws timeo=
ut error:

local address:=C2=A0 LID 0x0000, QPN 0x000150, PSN 0x23c9c7, GID 2001:db8:1=
71:2::20
remote address: LID 0x0000, QPN 0x00012e, PSN 0x96791a, GID 2001:db8:153:1:=
:10
Failed status transport retry counter exceeded (12) for wr_id 2
parse WC failed 1

What I have noticed with tcpdump on=C2=A0mlx5_3 is that the packets have So=
urce MAC equal to Destination MAC, which is wrong!
Also, I want to mention that both interfaces have also IPv4 addresses and i=
f I'm using IPv4 everything works perfect!

Below you can find my setup:

Ubuntu 22.0.4.5 (6.8.0-49-generic #49~22.04.1-Ubuntu) with 2 NICs connected=
 via a switch.

Network interfaces:

enp153s0np0:=C2=A0
...

inet6 fe80::a288:c2ff:fe7d:a8ca=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<link>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 2001:db8:153:1::10=C2=A0 prefixlen 64=C2=
=A0 scopeid 0x0<global>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether a0:88:c2:7d:a8:ca=C2=A0 txqueuelen 1000=
=C2=A0 (Ethernet)

and=C2=A0

enp171s0np0:
...
inet6 fe80::a288:c2ff:fe7d:a88a=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<link>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 2001:db8:171:2::20=C2=A0 prefixlen 64=C2=
=A0 scopeid 0x0<global>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether a0:88:c2:7d:a8:8a=C2=A0txqueuelen 1000=C2=
=A0 (Ethernet)

Here is the output of the ibv_devinfo:

hca_id: mlx5_2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 transport:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InfiniBand (0)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028.39.1002
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a088:c203:007d:a8ca
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_image_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a088:c203:007d:a8ca
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02c9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_part_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04129
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 board_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MT_0000000838
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_port_cnt:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:=C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PORT_ACTIVE (4)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 max_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
4096 (5)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 active_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024 =
(3)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sm_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lmc:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 link_layer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ether=
net

hca_id: mlx5_3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 transport:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InfiniBand (0)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028.39.1002
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a088:c203:007d:a88a
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_image_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a088:c203:007d:a88a
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02c9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_part_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04129
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 board_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MT_0000000838
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_port_cnt:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:=C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PORT_ACTIVE (4)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 max_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
4096 (5)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 active_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024 =
(3)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sm_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lmc:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 link_layer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ether=
net

Thank you,
Andrei=C2=A0





