Return-Path: <linux-rdma+bounces-23269-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xcJgAaVSV2oeJQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23269-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:28:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E875C7BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:28:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=P2oVs5Ao;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23269-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23269-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BC53034BE5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DB3FBB67;
	Wed, 15 Jul 2026 09:15:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3F3F86E6
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 09:15:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106912; cv=none; b=HODqAeQWACHy5nkIVXjoP7VSkbvngPxJhE2LXtY4gYjkxZQk8tXfgM2LdLYuBLsaKO/3uihulpCWnnJOs0mRgKr0vXhmHF06V+PvHprQJWEUGjZ2PQb9rw/lI7EbcXr8qcVxVywg2Mw2a2SrGOIKRP8knIB3J0GEwdoQ11YeP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106912; c=relaxed/simple;
	bh=U0wLunZ+ksxsKUgUhuFY7DzzK1hRCr+SfNrmEHjhBKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBEudSVEwea2KgXYKEB7ihrHIe3grZH3fk2C4eiubwY2MMfGPwYOZc4MR1O54ppSm+XU+HVqyOr4CgBggiTglspOSt3sReYOSfeVRAesFj4ZL1Ia/RE7EoSqwlDDEopKPPZ3F85/RU90inc7+LURCYrVKh++A5TzM7wLdxWhxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P2oVs5Ao; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cab973140bso60522305ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 02:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106910; x=1784711710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZMWqsCfTlHy2lVzd2lxa3+A6dF7VQJHSn7dRzv0VRU=;
        b=feFI+2aYI6ht0f4UnBWeGJlSrYf9ZFVdG/vJQJpaSUr+9MXSh1YIvwp40BQzirXbQr
         sfdNE7FI3OqKW6aZVnGtjUwzw7QLVcM8ObJW/I8BqD+1jNl+/VMPw7fsuRE2yKyFJb7G
         gk5+eBx9Egcioves8MKgBcBXD/1ntdIB7U1Txd7JQyxZbz8qjhocS9dkF5TdHQ4plUpq
         q/z7DhXcW6sOQTdMDQ1bA94h7gSwYnwLuOOepFcEx/ht7HgszbYbvQfgV1cOMyJS/Lq4
         Xzkx74Ugv0uTl3sBJrOCyqRBCsGtVcTc7bukX8twgpXggZfz9YBBq2u0K/KzjMomjNNv
         gcQA==
X-Forwarded-Encrypted: i=1; AHgh+RoYJz4ZiLcf85GOa9GD6awfPUkfXvUG7yhdGcGlPPpsaeiaSfMw/+D9ZFkBq7nZMSPvZ+ywPscJcR7H@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqBCzxQg6L4RfuVR4LheVOdqmbIi945uU8Q5nPHG3XZ7bq7yi
	QdNUW9W0OsUaKo4IwXqM1/GzdzF1F+g6w2Q/iqhxbFOR9lEhKb5tlQsmfXMSw0gsws4s2OUMXuC
	dLPePQUX4IP0uNZaiEPbUwdq0i37GI/wGaWzWTP+G3gvFoNj7zdgSY8d0UgVXwtlpcSGAEi1b1g
	GmlJjD5clmq++CNQ+djAhove+VxPnEmSSWSnDsPZx8DIDmIuid1AnOOMEsnafj9nFBwLYimHSW4
	dXBRf46rbAoVtA0xAPLWOiwcudUuw==
X-Gm-Gg: AfdE7cnrnLoPnCr8MlfVQLBqyLT8E3rgu71BtAhtGAZjjLwvkYPkFZHbhVDgaUseZw8
	C9Owns/ukxKg6SvT+Z2q8mioDFjS7YKZxRSInC3DttaeORHok/auRrE8QgjDG8YWBzjf2pVuGbt
	igvjekAOn9sN9tExRFKA5nFwmtXEHtGQ9Irho9jRRb/jKK6fM2dabTUMu/sgmhdBRGiMa7vwWsl
	oKj91rtjzvr1dpARvLftYj/d++MqwOdlbGaRgxdqkPWzieRr91tGMfus55QI6UhWvPptqgfzbrx
	f16sMzIdP9WBmpQKk9p8TOsP0aaa3Lg6jP6ZPiKPUUZysxG9SQEPP5SZvR2S3QK0NLX3FFa/TpO
	ROo37WCYr1uUimARYDDYyKCjKY0b46Q4eBD+oQDtdSRrNPMkSLZMpd1tzJpwTDGZ7CgEn7PaAqL
	zfThatjYUU5hSlWw4Q0Sz+26Bcwr29i036Hw/CVopmag2Y4miFkQ4BUg8y2Zg=
X-Received: by 2002:a17:902:c951:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2cf03cef367mr17036045ad.24.1784106909512;
        Wed, 15 Jul 2026 02:15:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9ccdb19sm26131125ad.29.2026.07.15.02.15.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:15:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so8556314b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784106907; x=1784711707; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZMWqsCfTlHy2lVzd2lxa3+A6dF7VQJHSn7dRzv0VRU=;
        b=P2oVs5AogaPzZxio0bhTCLVv8QMlyJ/hqrR41VBT6BhgRIANCgPnu/YWc0jFCNpG1A
         8pZrNXhMpHtV8O5ZaS4jAGGQbeJ4Z1XrnNOslIcmQM4qJQ/bszN1qWj12AYHbRmHLQQS
         NPqHyVjZDyC4qfZXWb/hDg6nE7GDUZtZzKlhg=
X-Forwarded-Encrypted: i=1; AHgh+RrbEVoAwRvv5Sda3Ic2ZxL3saUmKLjY++2Z0I6JXgOHKl56/YSKDL37f5oOMnjtfbH7aHSNvMSZ/ZPX@vger.kernel.org
X-Received: by 2002:a05:6a00:9a4:b0:848:420a:9cd5 with SMTP id d2e1a72fcca58-84a67361eabmr1750596b3a.53.1784106907627;
        Wed, 15 Jul 2026 02:15:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a4:b0:848:420a:9cd5 with SMTP id
 d2e1a72fcca58-84a67361eabmr1750569b3a.53.1784106907201; Wed, 15 Jul 2026
 02:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-kmem-dupliate-name-v1-1-85551c328155@nvidia.com>
In-Reply-To: <20260715-kmem-dupliate-name-v1-1-85551c328155@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 15 Jul 2026 14:44:53 +0530
X-Gm-Features: AUfX_mxyDvPMnQycMHJRST7BFAmd3INWrCweEeZQZpwhXGP6iwQch34PDFtgGRY
Message-ID: <CAH-L+nOh8UFgEHHrYanthQ8QTnvz6kh+Oqns=BPLuvvNDi5=CQ@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Use unique names for software steering caches
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Vesker <valex@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007de20a0656a2c25b"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23269-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:valex@nvidia.com,m:kliteyn@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:borntraeger@linux.ibm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2E875C7BF

--0000000000007de20a0656a2c25b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 1:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Each software steering domain creates its own slab caches, but all
> domains use the same names. When domains for two devices are alive at
> once, the second kmem_cache_create() triggers the following splat:
>
> WARNING: mm/slab_common.c:111 at __kmem_cache_create_args+0xca/0x480, CPU=
#18: devlink/331372
> Modules linked in: act_mirred act_skbedit cls_matchall act_gact cls_flowe=
r sch_ingress
> vhost_vdpa veth nfnetlink_cttimeout openvswitch macvtap macvlan vfio_ap k=
vm nf_nat_tftp
> nf_conntrack_tftp nsh nf_conncount vfio_pci_core irqbypass scsi_debug vho=
st_net tap tun
> vhost_vsock vmw_vsock_virtio_transport_common vsock vhost nft_masq nft_re=
ject_ipv4 act_csum
> cls_u32 sch_htb smc_diag smc ppp_deflate bsd_comp ppp_async crc_ccitt ppp=
_generic slhc loop
> algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reje=
ct_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4
> nf_tables mlx5_vdpa vdpa mlx5_ib dm_service_time ib_uverbs_support vringh=
 ib_core vhost_iotlb
> mlx5_core s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_c=
odel drm i2c_core
> dm_multipath drm_panel_orientation_quirks uvdevice diag288_wdt watchdog h=
mac_s390 prng aes_s390
> zfcp scsi_transport_fc pkey_pckmo pkey_cca pkey_ep11 zcrypt paes_s390 phm=
ac_s390 rng_core
> scsi_dh_alua pkey scsi_dh_rdac scsi_dh_emc crypto_engine autofs4 ecdsa_ge=
neric ecc sha512 [last unloaded: openvswitch]
> CPU: 18 UID: 0 PID: 331372 Comm: devlink Tainted: G        W           7.=
2.0-20260712.rc2.git0.e3321fa3034d.300.fc44.s390x+debug #1 PREEMPT
> Tainted: [W]=3DWARN
> Hardware name: IBM 9175 ME1 701 (LPAR)
> Krnl PSW : 0704c00180000000 0000038139a6771a (__kmem_cache_create_args+0x=
da/0x480)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0000000000000000 000003813b7de578 00000380b9e=
b8974
>             00000276c417f690 00000380b9eb8974 0000030144623348 0000027723=
4a1660
>             0000000000000020 00000380b9eb8974 00000277234a1600 000003813b=
686d30
>             0000000000000000 00000380b9e9a810 0000038139a6771a 0000030144=
623238
> Krnl Code: 0000038139a6770a: c02000ebb737       larl    %r2,000003813b7de=
578
>             0000038139a67710: b9040039           lgr     %r3,%r9
>            *0000038139a67714: c0e5006e2eb2       brasl   %r14,000003813a8=
2d478
>            >0000038139a6771a: a7390020           lghi    %r3,32
>             0000038139a6771e: b9040029           lgr     %r2,%r9
>             0000038139a67722: c0e5006cf98f       brasl   %r14,000003813a8=
06a40
>             0000038139a67728: ec26018e007c       cgij    %r2,0,6,00000381=
39a67a44
>             0000038139a6772e: 58d0f0a4           l       %r13,164(%r15)
> Call Trace:
>   [<0000038139a6771a>] __kmem_cache_create_args+0xda/0x480
> ([<0000038139a676a2>] __kmem_cache_create_args+0x62/0x480)
>   [<00000380b9da1c70>] dr_domain_init_mem_resources+0x80/0x240 [mlx5_core=
]
>   [<00000380b9da226e>] dr_domain_init_resources.constprop.0+0x7e/0x2c0 [m=
lx5_core]
>   [<00000380b9da28b2>] mlx5dr_domain_create+0x132/0x250 [mlx5_core]
>   [<00000380b9dc1e20>] mlx5_cmd_dr_create_ns+0x30/0x90 [mlx5_core]
>   [<00000380b9cd8dbe>] mlx5_flow_namespace_set_mode+0x6e/0x130 [mlx5_core=
]
>   [<00000380b9d846ec>] esw_create_offloads_fdb_tables+0xac/0x5a0 [mlx5_co=
re]
>   [<00000380b9d865b6>] esw_offloads_steering_init+0x1c6/0x480 [mlx5_core]
>   [<00000380b9d86e8e>] esw_offloads_enable+0x13e/0x410 [mlx5_core]
>   [<00000380b9d7b04a>] mlx5_eswitch_enable_locked+0x36a/0x540 [mlx5_core]
>   [<00000380b9d84ff0>] esw_offloads_start+0x50/0x1d0 [mlx5_core]
>   [<00000380b9d8774a>] mlx5_devlink_eswitch_mode_set+0x35a/0x3f0 [mlx5_co=
re]
>   [<000003813a791e68>] devlink_nl_eswitch_set_doit+0x88/0x120
>   [<000003813a5b93ea>] genl_family_rcv_msg_doit+0xea/0x150
>   [<000003813a5b95c2>] genl_family_rcv_msg+0x172/0x210
>   [<000003813a5b96c2>] genl_rcv_msg+0x62/0xc0
>   [<000003813a5b7cac>] netlink_rcv_skb+0x5c/0x120
>   [<000003813a5b8f0c>] genl_rcv+0x3c/0x50
>   [<000003813a5b74a4>] netlink_unicast+0x1f4/0x2b0
>   [<000003813a5b783c>] netlink_sendmsg+0x2dc/0x460
>   [<000003813a4c9764>] __sock_sendmsg+0x64/0xd0
>   [<000003813a4cc878>] __sys_sendto+0x108/0x160
>   [<000003813a4cdf50>] __do_sys_socketcall+0x350/0x460
>   [<000003813a8184d2>] __do_syscall+0x172/0x750
>   [<000003813a82d5d2>] system_call+0x72/0x90
>
> Prefix each cache name with the device name to make it unique.
>
> Fixes: fd785e5213f0 ("net/mlx5: DR, Allocate icm_chunks from their own sl=
ab allocator")
> Fixes: fb628b71fb2a ("net/mlx5: DR, Allocate htbl from its own slab alloc=
ator")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Closes: https://lore.kernel.org/all/a3cea501-4d1f-47d5-b6d0-fcda9a0aab16@=
linux.ibm.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--0000000000007de20a0656a2c25b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgrmS27G/YuJbSfXN15UDSZZbVRTZK
9+A187Le6BivBoUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
NzE1MDkxNTA3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEA4TT1LhyN3GACicu6fUjX1WLaBsuk9MHen3yzJmxiDndHqF55L6SrJ5vQqvFZhvma
5KIqXXfozm1l4PRQtIZ6qkRZzsohM3DWTsbZQlLV0KFdtDZpgar5mrmmy7TIIcNslmj4tW5MKD5P
Zf7PNsdqg1O1dccQJgBN8EFGm2e35Zz6BYiY7GIfMMIgJCHkBSD/zUVrTjuKuluNNX9UTuviwsu2
TaV/vCCrDzjwFOXvWUOV7MQgIrXmxMBU9miGbNKuvqf+VzinBU58KGevOmUWLAUuuKxd7lPu+P/Y
JyZtBGS+yd+duqK2ciuCgfhySEAr6FQAiV6qufuk/Xv5ieB7qw==
--0000000000007de20a0656a2c25b--

