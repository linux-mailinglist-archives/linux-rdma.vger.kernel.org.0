Return-Path: <linux-rdma+bounces-8724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0DA63302
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BDE3A7365
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 01:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB2D517;
	Sun, 16 Mar 2025 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwfTwkzr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A518290F
	for <linux-rdma@vger.kernel.org>; Sun, 16 Mar 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742086958; cv=none; b=BaJialjItZctYlV6TyMS3Ko5MhRbWDlVJlsAaHTWi3lZWDFm6H6ZQGvZD50HCMiQJuu1l5TglcDbLx5DghGBKq1spG374lQskb92LhrhJjg78L9BUbfaMO9WyWupxQOpzTCVJjVXSB+99OtZ2wJ+tcvO18t6y68VpeJK7Zri6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742086958; c=relaxed/simple;
	bh=Ruu7DwkIG0rW0/noK2IDcVEOCv6ajEbykwNKOn08Cl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcYhR3NgDUonC5PIbOVfd5UD5Jtw3DgIRlEULEDNz+bHC1X7cVuYOdFta3un8EETUM5fQEgbbQypGXnE0Hhn1UB06m3duqqzRLtiVq2uQxjU8AmE/E0s4YaXAUzCCaiRjSduQ6kAg2OYPCa5IZJ6k+qVuX/jOt+CYADsEZI98Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwfTwkzr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7430e27b2so624592166b.3
        for <linux-rdma@vger.kernel.org>; Sat, 15 Mar 2025 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742086954; x=1742691754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba5sYtP2n/1ZkR+6uR4aVmnpAkOYAD4fGIWbncTJBDM=;
        b=bwfTwkzrHnmSs8GVkqdP3er0ScDAgwL0DcQaYCBLWEUSvehQaubQ1ixaRyvGfuE2yF
         vHQUEzdumO7akbsYB9Pgup2KPH8punhBQEf94GrfUjDmaplRAlQDbgJk2Hh24+FYtnF3
         wRcx4de51NQEu27LTerGtu5vnNQhwM2aKddnD4Mo06vFLl2wCd4emIpI+EYUE7Gqy9A1
         ek26OUg277/9EFGCGqXeDH+8YjHBQ+8DH6rv8EU26LOIHCyY2Gq9YqsQDG1LTU4/i/dk
         beu6Ogb5xQ5t2PN8yDt0+6yds2yF5pexPvJJkGTWlRdotIeqrzVc7Fe926YHWZI23VDe
         gOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742086954; x=1742691754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba5sYtP2n/1ZkR+6uR4aVmnpAkOYAD4fGIWbncTJBDM=;
        b=Fc7V5MqkQaF5iD/e+la/1eiblfOK0LdtuqZ8hm1GNM1uBBt07tdsBUVb3bUhOJ9RHs
         BL1QDG4MKwCiq6GaN08Kujmu7248IxhET4wfcIELLW6D291bMvXiaLUe//l0dU4IWm5W
         vZAhu7PSNVJVQD1VDZQj3Sb16VKPtLuMOD0q87PHvQKAGCO0wxe9/xGBNZ+lncZVMngc
         eUm8MEb0SffCDu97vX10Xl/aUUmohBEH+A4ud+675rgDpL+lsRByPwKJB0y0Z43wJSRG
         QiktHU+P3mYRhA95LA6cMENSap3KY/pT8S1gi8TTKL1++9dTY/W8qay5+jnL+CCCOyAl
         u9TQ==
X-Gm-Message-State: AOJu0YwJc7brgQnNbdxva4XI/nrdu8WmNJoBcxc5p91aJjjx31EFnoQZ
	G0a7deyExKZ1c6lQy9LUtYtovnlx5z2gS2e3icWN+6wwVvfkE3qpil6je4WT0TQC1c351FqCv7k
	xOUTdtmZ9oPiPXn3LhDdRpm1XVuFCqZ7976tsUA==
X-Gm-Gg: ASbGncurWF4SYlO8VNA+yLrX15l9PKLiT+wmDFMuuROEiL5vcTdDCUv8fPRirJt5SpA
	NjMo9BbVXbOj4zo5B3YlEeVyBTrLtWUIcK4L9ecFY3Ov814W5OUJjh81ciJuB96IPQ/QQp6JQAn
	ATLddt4MOtXwUz/DBGxSGmMz1HqXaOROy/5SKC
X-Google-Smtp-Source: AGHT+IGOq3YCLCyuQ6abnM4EE6DpDttbK624vqwguWNbyE5KvCAWqEIWjNUOcVlU2QdWfAh8vHfAPt2SqZNmfaOqlBY=
X-Received: by 2002:a17:906:c10e:b0:ac2:cdc7:fa61 with SMTP id
 a640c23a62f3a-ac33027c3f3mr737297766b.25.1742086953929; Sat, 15 Mar 2025
 18:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-1TMMRS7C7015ZSCJ1zXCWenqxskzNONZdsSVW9TmFPDXBYA@mail.gmail.com>
 <a4b877ca-acbd-4c7a-9d32-00ee56ea6cf0@linux.dev>
In-Reply-To: <a4b877ca-acbd-4c7a-9d32-00ee56ea6cf0@linux.dev>
From: Yiyi Hu <yiyihu@gmail.com>
Date: Sun, 16 Mar 2025 09:02:22 +0800
X-Gm-Features: AQ5f1Jrhhlc7v13ZpWga8I21k0ZlU-5EenfGpX5p2Q80dcgqNYuVW2IycjL2UiA
Message-ID: <CA+-1TMMBVoVcnsg9dV-bpBTzTTx0r=bas9w6tNcVh4_KfB6BEw@mail.gmail.com>
Subject: Re: When upgrading to kernel 6.12.4, I got the following error with
 rdma_rxe module.
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, (Sorry to repost, Clicked "Reply" instead of "Reply to all")

I don't use 'git bisect' for now, Will report back when I have
enough time to setup a separate host for 'git bisect',
According to new observations, It seems it's triggered when user tries
to use the rdma link over the veth pair,
I see the same issue with different NIC, The network is something like
 veth-port-a  <--> br-with-vlan-filtering[veth-port-ap, other-phy-ports]
The error are as almost same follows:

[657667.100894] ------------[ cut here ]------------
[657667.100909] WARNING: CPU: 0 PID: 738197 at
drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0xbc/0x110
[rdma_rxe]
[657667.100952] Modules linked in: rdma_rxe xt_addrtype xt_mark
xt_comment macvtap macvlan overlay iscsi_target_mod target_core_user
uio target_core_pscsi target_core_file target_core_iblock
target_core_mod nvmet_tcp brd xt_tcpudp xt_nat xt_multiport
xt_conntrack xt_set ip_set bcache pppoe pppox ppp_generic slhc nbd
zram virtio_vdpa vduse vdpa nvme_rdma nvmet_rdma nvmet nvme_tcp
nvme_fabrics nvme_keyring msr thermal rt2800usb rt2x00usb rt2800lib
rt2x00lib mac80211 nf_nat_pptp nf_conntrack_pptp nf_conntrack_tftp
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp
nf_conntrack_ftp nct6775 nct6775_core hwmon_vid vhost_net tun vhost
vhost_iotlb tap k10temp iptable_nat xt_MASQUERADE rpcsec_gss_krb5
iptable_filter ip_tables x_tables tcp_diag inet_diag wireguard
curve25519_x86_64 libcurve25519_generic libchacha20poly1305
chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel libchacha
nfsv4 nfs netfs veth bridge bonding tls nft_nat nft_masq nft_chain_nat
nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cfg80211
[657667.101117]  nf_tables rfkill 8021q garp mrp stp llc rpcrdma
rdma_ucm ib_iser ib_umad rdma_cm ib_ipoib iw_cm ib_cm coretemp
intel_uncore_frequency intel_uncore_frequency_common ee1004 evdev
mxm_wmi x86_pkg_temp_thermal kvm_intel kvm rapl intel_cstate i2c_i801
intel_uncore i2c_mux pcspkr i2c_smbus i915 rtc_cmos intel_gtt
i2c_algo_bit drm_buddy video drm_display_helper intel_pmc_core wmi ttm
intel_vsec cec pmt_telemetry drm_kms_helper pmt_class button acpi_pad
mlx4_ib ib_uverbs ib_core nfsd sch_fq_codel auth_rpcgss nfs_acl lockd
grace sunrpc drm fuse loop dm_snapshot raid0 dm_cache_smq dm_cache
dm_persistent_data dm_bio_prison dm_bufio mlx4_en sd_mod
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 sha1_ssse3 nvme ahci ixgbe libahci mdio
mdio_devres nvme_core libphy e1000e hwmon aesni_intel crypto_simd
xhci_pci ptp i2c_core nvme_auth libata mlx4_core xhci_hcd dm_mirror
dm_region_hash dm_log be2iscsi iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi dm_multipath dm_mod efivarfs
[657667.101341]  dmi_sysfs
[657667.101392] CPU: 0 UID: 0 PID: 738197 Comm: kworker/u9:2 Tainted:
G        W I        6.12.18-gentoo #2
[657667.101409] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[657667.101415] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./B150A-X1/Hyper, BIOS P7.20 11/18/2016
[657667.101425] RIP: 0010:rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
[657667.101449] Code: 00 f0 0f c1 87 80 00 00 00 83 f8 01 74 3a 85 c0
7f 96 5b be 03 00 00 00 5d 48 89 d7 41 5c e9 cb 4a 95 df 41 f6 04 24
01 75 27 <0f> 0b 5b 5d 41 5c c3 83 e8 01 83 f8 0f 77 a3 49 8d bc 24 d8
03 00
[657667.101464] RSP: 0018:ffffc90000003d60 EFLAGS: 00010246
[657667.101474] RAX: 0000000000000000 RBX: ffff8881033dde00 RCX:
0000000000000000
[657667.101482] RDX: ffff888233873d00 RSI: 000000000000000e RDI:
ffff888233873d00
[657667.101490] RBP: 0000000000000000 R08: 004041d5d8b05506 R09:
f96183f30388e37b
[657667.101498] R10: 0000000000000000 R11: ffff888101b70980 R12:
ffff888101b70000
[657667.101506] R13: ffff88810704ca40 R14: 00000000fffffea4 R15:
ffff88810034ca40
[657667.101514] FS:  0000000000000000(0000) GS:ffff888463c00000(0000)
knlGS:0000000000000000
[657667.101523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[657667.101530] CR2: 00007fb41fadd7e0 CR3: 00000001c52fa005 CR4:
00000000003726f0
[657667.101539] Call Trace:
[657667.101546]  <IRQ>
[657667.101551]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
[657667.101572]  ? __warn.cold+0x93/0xed
[657667.101590]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
[657667.101609]  ? report_bug+0xe2/0x170
[657667.101622]  ? handle_bug+0x4f/0x90
[657667.101632]  ? exc_invalid_op+0x13/0x60
[657667.101641]  ? asm_exc_invalid_op+0x16/0x20
[657667.101656]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
[657667.101675]  skb_release_head_state+0x20/0x90
[657667.101685]  napi_consume_skb+0x3e/0x100
[657667.101696]  ixgbe_poll+0x21c/0x1210 [ixgbe]
[657667.101740]  __napi_poll+0x25/0x150
[657667.101753]  net_rx_action+0x301/0x370
[657667.101767]  ? wakeup_preempt+0x2f/0x60
[657667.101775]  ? __raise_softirq_irqoff+0x16/0x70
[657667.101787]  ? ixgbe_msix_clean_rings+0x39/0x40 [ixgbe]
[657667.101812]  handle_softirqs+0xf1/0x2b0
[657667.101825]  irq_exit_rcu+0x74/0xd0
[657667.101835]  common_interrupt+0xb8/0xd0
[657667.101846]  </IRQ>
[657667.101850]  <TASK>
[657667.101855]  asm_common_interrupt+0x22/0x40
[657667.101867] RIP: 0010:finish_task_switch.isra.0+0xdc/0x2e0
[657667.101881] Code: 01 00 00 f0 41 ff 4d 00 0f 84 60 01 00 00 81 7d
d4 80 00 00 00 0f 84 60 01 00 00 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
5f 5d c3 <49> 8b 9e 00 03 00 00 48 85 db 74 bb 48 8b 43 10 48 89 df 65
8b 35
[657667.101895] RSP: 0018:ffffc9000607fda8 EFLAGS: 00000282
[657667.101903] RAX: 0000000080000001 RBX: ffff888463c33940 RCX:
0000000000000000
[657667.101910] RDX: 0000000000000002 RSI: ffffffff8214864a RDI:
00000000ffffffff
[657667.101918] RBP: ffffc9000607fdd8 R08: 00000000000162ad R09:
ffff8881bbef2dc0
[657667.101925] R10: ffff888103b9b510 R11: 0000000000000000 R12:
ffff8881bbef2dc0
[657667.101932] R13: 0000000000000000 R14: ffff888233873d00 R15:
0000000000000000
[657667.101944]  ? finish_task_switch.isra.0+0xa0/0x2e0
[657667.101957]  __schedule+0x3dd/0x14d0
[657667.101966]  ? flush_delayed_work+0x40/0x40
[657667.101982]  schedule+0x26/0xf0
[657667.101989]  worker_thread+0x209/0x430
[657667.102002]  ? _raw_spin_lock_irqsave+0x17/0x40
[657667.102014]  ? flush_delayed_work+0x40/0x40
[657667.102026]  kthread+0xda/0x110
[657667.102036]  ? kthread_park+0x80/0x80
[657667.102046]  ret_from_fork+0x2d/0x50
[657667.102054]  ? kthread_park+0x80/0x80
[657667.102064]  ret_from_fork_asm+0x11/0x20
[657667.102079]  </TASK>
[657667.102083] ---[ end trace 0000000000000000 ]---

On Thu, Dec 26, 2024 at 7:50=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2024/12/25 21:04, Yiyi Hu =E5=86=99=E9=81=93:
> > Hi, I'm using 6.6.x kernel, after I upgraded to kernel 6.12.x for my
> > home server, I got the following error. Which causes soft rdma doesn't
> > work for 6.12.x with my setup.
>
> I read this bug descriptions for several times. To be honest, I am also
> confused with this problem.
>
> It seems that with 6.6.x kernel, it can work well. And with 6.12.x, it
> can not work.
>
> So maybe "git bisect" is a good tool to find the commit that causes this
> problems.
>
> Zhu Yanjun
>
> >
> > The kernel warning is:
> >
> > # [  134.041117] ------------[ cut here ]------------
> > # [  134.041120] WARNING: CPU: 9 PID: 0 at
> > drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0xbc/0x110
> > [rdma_rxe]
> > # [  134.041128] Modules linked in: dm_cache_smq dm_cache
> > dm_persistent_data dm_bio_prison 8021q garp mrp macvtap macvlan veth
> > dummy bridge stp llc nft_ct nf_tables sch_fq_codel virtio_vdpa vduse
> > vdpa rdma_rxe ip6_udp_tunnel udp_tunnel nvme_rdma nvmet_rdma raid456
> > async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> > raid6_pq raid1 raid0 bcache nvmet nvme_auth dm_writecache msr thermal
> > rpcrdma rdma_ucm ib_iser ib_umad rdma_cm ib_ipoib iw_cm ib_cm
> > rt2800usb rt2x00usb rt2800lib rt2x00lib ee1004 wmi_bmof mxm_wmi evdev
> > mac80211 snd_hda_codec_realtek snd_hda_codec_generic
> > snd_hda_scodec_component cfg80211 rfkill snd_hda_intel
> > snd_intel_dspcfg nf_conntrack_tftp snd_intel_sdw_acpi
> > nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp
> > nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> > snd_hda_codec nct6775 snd_hda_core nct6775_core snd_hwdep hwmon_vid
> > vhost_net snd_pcm mlx4_ib tun kvm_amd snd_timer vhost gpio_amdpt
> > ib_uverbs vhost_iotlb i2c_piix4 snd tap rapl pcspkr soundcore
> > i2c_smbus rtc_cmos wmi
> > # [  134.041242]  button gpio_generic ib_core kvm k10temp drm fuse
> > loop dmi_sysfs dm_snapshot dm_bufio mlx4_en sd_mod nvme_tcp
> > nvme_fabrics nvme ixgbe crct10dif_pclmul mdio crc32_pclmul mdio_devres
> > crc32c_intel igb ghash_clmulni_intel i2c_algo_bit sha512_ssse3 libphy
> > nvme_core sha256_ssse3 ptp sha1_ssse3 hwmon xhci_pci aesni_intel ahci
> > mlx4_core crypto_simd libahci xhci_hcd libata i2c_core sunrpc
> > dm_mirror dm_region_hash dm_log be2iscsi iscsi_tcp libiscsi_tcp
> > libiscsi scsi_transport_iscsi dm_multipath dm_mod efivarfs
> > # [  134.041324] CPU: 9 UID: 0 PID: 0 Comm: swapper/9 Tainted: G
> >   W          6.12.4-gentoo #2
> > # [  134.041329] Tainted: [W]=3DWARN
> > # [  134.041331] Hardware name: To Be Filled By O.E.M. X370 Killer
> > SLI/X370 Killer SLI, BIOS P10.31 08/23/2024
> > # [  134.041335] RIP: 0010:rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> > # [  134.041342] Code: 00 f0 0f c1 87 80 00 00 00 83 f8 01 74 39 85 c0
> > 7f 96 5b 5d be 03 00 00 00 48 89 d7 41 5c e9 7b 43 39 e0 41 f6 04 24
> > 01 75 26 <0f> 0b 5b 5d 41 5c c3 ff c8 83 f8 0f 77 a4 49 8d bc 24 d8 03
> > 00 00
> > # [  134.041347] RSP: 0018:ffffc90000338d20 EFLAGS: 00010246
> > # [  134.041352] RAX: 0000000000000000 RBX: ffff888101b38200 RCX:
> > 0000000000000000
> > # [  134.041355] RDX: ffff88810092de80 RSI: 000000000000000e RDI:
> > ffff88810092de80
> > # [  134.041358] RBP: 0000000000000000 R08: ffff8881253b0000 R09:
> > 0000000000000001
> > # [  134.041360] R10: ffff8881251fac00 R11: 0000000000000080 R12:
> > ffff888125220000
> > # [  134.041364] R13: 0000000000000056 R14: 0000000000010000 R15:
> > ffff888101b38200
> > # [  134.041367] FS:  0000000000000000(0000) GS:ffff889fbee40000(0000)
> > knlGS:0000000000000000
> > # [  134.041370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > # [  134.041373] CR2: 000055ec3e726750 CR3: 000000000341b000 CR4:
> > 0000000000350ef0
> > # [  134.041376] Call Trace:
> > # [  134.041379]  <IRQ>
> > # [  134.041381]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> > # [  134.041388]  ? __warn.cold+0x93/0xed
> > # [  134.041392]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> > # [  134.041398]  ? report_bug+0xe2/0x170
> > # [  134.041402]  ? handle_bug+0x4f/0x90
> > # [  134.041405]  ? exc_invalid_op+0x13/0x60
> > # [  134.041409]  ? asm_exc_invalid_op+0x16/0x20
> > # [  134.041413]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> > # [  134.041420]  skb_release_head_state+0x20/0x90
> > # [  134.041424]  napi_consume_skb+0x3e/0x100
> > # [  134.041428]  mlx4_en_free_tx_desc+0x11d/0x200 [mlx4_en]
> > # [  134.041433]  mlx4_en_process_tx_cq+0x182/0x560 [mlx4_en]
> > # [  134.041439]  mlx4_en_poll_tx_cq+0x28/0x70 [mlx4_en]
> > # [  134.041443]  __napi_poll+0x25/0x150
> > # [  134.041447]  net_rx_action+0x300/0x370
> > # [  134.041452]  ? mlx4_msi_x_interrupt+0xd/0x20 [mlx4_core]
> > # [  134.041465]  handle_softirqs+0xf0/0x2a0
> > # [  134.041469]  irq_exit_rcu+0x74/0xd0
> > # [  134.041473]  common_interrupt+0xb8/0xd0
> > # [  134.041476]  </IRQ>
> > # [  134.041478]  <TASK>
> > # [  134.041480]  asm_common_interrupt+0x22/0x40
> > # [  134.041484] RIP: 0010:cpuidle_enter_state+0xaf/0x410
> > # [  134.041488] Code: de 01 00 00 e8 d2 9c 5f ff e8 dd f2 ff ff 49 89
> > c5 0f 1f 44 00 00 31 ff e8 9e bd 5e ff 45 84 ff 0f 85 b0 01 00 00 fb
> > 45 85 f6 <0f> 88 88 01 00 00 48 8b 04 24 49 63 ce 4c 89 ea 48 6b f1 68
> > 48 29
> > # [  134.041492] RSP: 0018:ffffc9000013be78 EFLAGS: 00000202
> > # [  134.041496] RAX: ffff889fbee40000 RBX: ffff888104c68400 RCX:
> > 0000000000000000
> > # [  134.041500] RDX: 0000001f357196a8 RSI: ffffffff82142fc3 RDI:
> > ffffffff82146c8f
> > # [  134.041503] RBP: 0000000000000002 R08: 0000000000000002 R09:
> > 0000000000000000
> > # [  134.041506] R10: 0000000000000018 R11: ffff889fbee72144 R12:
> > ffffffff824dfd40
> > # [  134.041509] R13: 0000001f357196a8 R14: 0000000000000002 R15:
> > 0000000000000000
> > # [  134.041513]  ? cpuidle_enter_state+0xa2/0x410
> > # [  134.041517]  cpuidle_enter+0x29/0x40
> > # [  134.041520]  do_idle+0x19a/0x200
> > # [  134.041524]  cpu_startup_entry+0x25/0x30
> > # [  134.041527]  start_secondary+0xfe/0x120
> > # [  134.041530]  common_startup_64+0x13e/0x141
> > # [  134.041535]  </TASK>
> > # [  134.041537] ---[ end trace 0000000000000000 ]---
> >
> > the system has a "Hewlett-Packard Company InfiniBand FDR/Ethernet
> > 10Gb/40Gb 2-port 544+FLR-QSFP Adapter"
> > I created a software bridge named br-fp and bridge 2 ports on this adap=
ter,
> > I also created a veth pair (venfp <-> venfpbr), venfpbr is connected
> > to bridge br-fp.
> > then I do 'rdma link add rxe_venfp type rxe netdev venfp', If I try to
> > do rdma connect to remote storge, the error occurs.
> >
> > if you need other info, Please tell me.
> >
> > Thanks.
>

