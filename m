Return-Path: <linux-rdma+bounces-10843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F47AC6635
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2B7AB061
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA7279345;
	Wed, 28 May 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qR++6nd/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Oo86QWv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCnODgfV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLQRoGZa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26618211A35
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425590; cv=none; b=pwZupZV1uUuU1Gk2io2DmTrfQX42JtACNN+NIOB0jLXtDsgnNH30Q/KylXIaHLUjE5oxDB5UwxMMFcZl7m65u8V/c5zonfzOq6p10BwioIKuDjiACHrv8GEVOSdVN9b4I/9MXDiaBISdC+OISNzpuqvum+2QotrSCROCK6+TNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425590; c=relaxed/simple;
	bh=SRB9D/p75VQftd5JKNweE/hMSLClABHlCGmf2KecD1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjmwS0nhVmy0Doq4wRPx3wtVPOZ7XNRV5scmsk/+222fojPuDcRkHzXObPnyMzAh5gdngj8q48RNTq/seu/Px+qLwv789aCdJA8e1TKSDwf8KRlYHNZzuRYktzNYUnhLb/OTgQK7UY2srV5b00VVQh3hiB4ZjnevjO1vvhW0g3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qR++6nd/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Oo86QWv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCnODgfV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qLQRoGZa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3052921190;
	Wed, 28 May 2025 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748425585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/foYHe1tnjAriPPhGe6i1j2opUe2LuwMyMySRGVhTSw=;
	b=qR++6nd/I19QcABe/Jg//BtN5RFBf1CwooYZpRipDCDK1WIfnmQrDOsUZXRWrCFF50w50C
	QBDkKw6Lmc5htEcAqsKGbYfGBwA/qabmpzmFFUwywg6NUlWvWRNXbXiJB1qPqm6fGOWL0R
	evTT9DnhrlDLuTSl0DHh3ESJSoFHl6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748425585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/foYHe1tnjAriPPhGe6i1j2opUe2LuwMyMySRGVhTSw=;
	b=0Oo86QWvEhQFfd8kCx8Vt6XWfgWPRmANQHCqoJqgXPhTVdzR778EaWdZ4vxaA0CQVbaVgE
	BQz+VmfkIDU9ClBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fCnODgfV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qLQRoGZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748425584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/foYHe1tnjAriPPhGe6i1j2opUe2LuwMyMySRGVhTSw=;
	b=fCnODgfVoiI0s5mB2D2Ncd8FO/uJDFg9VyyKb7sCXWKk20oesZSzzgJfV8AqdRKoVqepPg
	GChKv1UP5Pi5lZ1stYFxo0B1hnu93Ehi4+HblqpnhyavePiSe1cQyEhMK9LqwaQDXXvPJO
	BbuWitd7s3iG1KWbRBlS5njaL9tuPqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748425584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/foYHe1tnjAriPPhGe6i1j2opUe2LuwMyMySRGVhTSw=;
	b=qLQRoGZao55mwkI7eGK/5tLKxbwpz82XWY6X/EijS+8MmD1SaURmkemvhgygoDo8Ki9mFW
	45778y87C/oGhoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD79136E3;
	Wed, 28 May 2025 09:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /lT8AXDbNmgdcQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 May 2025 09:46:24 +0000
Message-ID: <610d1a69-e237-43ec-b554-d52b5308ace1@suse.cz>
Date: Wed, 28 May 2025 11:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm, slab] 6431f06eec:
 WARNING:at_include/linux/mm.h:#skb_append_pagefrags
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org
References: <202505221248.595a9117-lkp@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <202505221248.595a9117-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3052921190
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 5/22/25 06:54, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
>=20
> we noticed the WARN added in this commit is hit in our tests. not sure =
if it's
> expected. below full report FYI.

It's expected in the sense that if somebody is doing the wrong thing, the=
re
would be a report. So it seems that has now happened :)

> kernel test robot noticed "WARNING:at_include/linux/mm.h:#skb_append_pa=
gefrags" on:
>=20
> commit: 6431f06eecf44e7b8d42237cb0e166a456f491ad ("mm, slab: warn when =
increasing refcount on large kmalloc page")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master=


FYI that's
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=
=3Dslab/for-6.16/testing&id=3D6431f06eecf44e7b8d42237cb0e166a456f491ad

so we have skb_splice_from_iter() calling skb_append_pagefrags() and that=

does a get_page(). But this warning means one of the pages is a kmalloc()=

with size >8kb that is using the page allocator and not slab caches. But
that 8kb threshold is an implementation detail, so we want all kmalloc()
allocated buffers to behave the same and use frozen pages and thus not al=
low
get_page().

Note skb_splice_from_iter() has above the call to skb_append_pagefrags():=


if (WARN_ON_ONCE(!sendpage_ok(page)))
    goto out;

and sendpage_ok() is:

return !PageSlab(page) && page_count(page) >=3D 1;

Thus if we went ahead with frozen pages for large kmalloc(), sendpage_ok(=
)
would start marking them as not ok, which seems like the right thing. But=

this callsite would still produce a WARN_ON_ONCE(), so that suggests it's=

not really expected to for kmalloc() pages to reach this code.

It's possible that some other code using sendpage_ok() elsewhere prevents=

this from happening, and this WARN_ON_ONCE() is just a safety double chec=
k.
Or not, and something (siw?) needs to be fixed to e.g. stop using kmalloc=
()
and use the page allocator directly. I don't know this code so I'm just
ccing networking and siw maintainers. Thanks in advance.

Vlastimil

>=20
> [test failed on linux-next/master 7bac2c97af4078d7a627500c9bcdd5b033f97=
718]
>=20
> in testcase: blktests
> version: blktests-x86_64-613b837-1_20250520
> with following parameters:
>=20
> 	disk: 1SSD
> 	test: nvme-group-00
> 	nvme_trtype: rdma
> 	use_siw: true
>=20
>=20
>=20
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylak=
e) with 16G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202505221248.595a9117-lkp@inte=
l.com
>=20
>=20
> [  130.177740][ T2674] ------------[ cut here ]------------
> [ 130.183066][ T2674] WARNING: CPU: 6 PID: 2674 at include/linux/mm.h:1=
552 skb_append_pagefrags (kbuild/obj/consumer/x86_64-rhel-9.4-func/includ=
e/linux/mm.h:1552 kbuild/obj/consumer/x86_64-rhel-9.4-func/net/core/skbuf=
f.c:4518)=20
> [  130.192642][ T2674] Modules linked in: siw ib_uverbs nvmet_rdma nvme=
t nvme_rdma nvme_fabrics rdma_cm nvme_auth nvme_core iw_cm ib_cm ib_core =
xfs dm_multipath btrfs blake2b_generic xor zstd_compress raid6_pq intel_r=
apl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp snd_soc_a=
vs snd_hda_codec_hdmi coretemp snd_soc_hda_codec snd_hda_ext_core sd_mod =
snd_ctl_led snd_soc_core sg snd_hda_codec_realtek kvm_intel snd_hda_codec=
_generic snd_compress ipmi_devintf snd_hda_scodec_component ipmi_msghandl=
er i915 kvm snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi intel_gtt s=
nd_hda_codec cec irqbypass ghash_clmulni_intel drm_buddy snd_hda_core sha=
512_ssse3 ttm snd_hwdep sha256_ssse3 drm_display_helper sha1_ssse3 snd_pc=
m ahci mei_wdt drm_client_lib drm_kms_helper rapl libahci mei_me snd_time=
r intel_cstate video wmi_bmof i2c_i801 snd intel_uncore mei pcspkr soundc=
ore i2c_smbus libata serio_raw intel_pmc_core intel_pch_thermal intel_vse=
c pmt_telemetry wmi acpi_pad pmt_class binfmt_misc drm fuse loop dm_mod i=
p_tables
> [  130.192875][ T2674]  [last unloaded: ib_uverbs]
> [  130.286562][ T2674] CPU: 6 UID: 0 PID: 2674 Comm: siw_tx/6 Tainted: =
G S                  6.15.0-rc3-00001-g6431f06eecf4 #1 PREEMPT(voluntary)=

> [  130.299313][ T2674] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [  130.303929][ T2674] Hardware name: HP HP Z240 SFF Workstation/802E, =
BIOS N51 Ver. 01.63 10/05/2017
> [ 130.312877][ T2674] RIP: 0010:skb_append_pagefrags (kbuild/obj/consum=
er/x86_64-rhel-9.4-func/include/linux/mm.h:1552 kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/net/core/skbuff.c:4518)=20
> [ 130.318708][ T2674] Code: a2 ff ff 48 8b 4c 24 18 4c 8b 4c 24 10 8b 5=
4 24 08 4c 8b 14 24 e9 1b fb ff ff 4c 8d 60 ff e9 47 fb ff ff 0f 0b e9 bb=
 fb ff ff <0f> 0b e9 7b fb ff ff b8 a6 ff ff ff e9 d7 fc ff ff 0f 0b 31 f=
f e9
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	a2 ff ff 48 8b 4c 24 	movabs %al,0x4c18244c8b48ffff
>    7:	18 4c=20
>    9:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
>    d:	8b 54 24 08          	mov    0x8(%rsp),%edx
>   11:	4c 8b 14 24          	mov    (%rsp),%r10
>   15:	e9 1b fb ff ff       	jmp    0xfffffffffffffb35
>   1a:	4c 8d 60 ff          	lea    -0x1(%rax),%r12
>   1e:	e9 47 fb ff ff       	jmp    0xfffffffffffffb6a
>   23:	0f 0b                	ud2
>   25:	e9 bb fb ff ff       	jmp    0xfffffffffffffbe5
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	e9 7b fb ff ff       	jmp    0xfffffffffffffbac
>   31:	b8 a6 ff ff ff       	mov    $0xffffffa6,%eax
>   36:	e9 d7 fc ff ff       	jmp    0xfffffffffffffd12
>   3b:	0f 0b                	ud2
>   3d:	31 ff                	xor    %edi,%edi
>   3f:	e9                   	.byte 0xe9
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	0f 0b                	ud2
>    2:	e9 7b fb ff ff       	jmp    0xfffffffffffffb82
>    7:	b8 a6 ff ff ff       	mov    $0xffffffa6,%eax
>    c:	e9 d7 fc ff ff       	jmp    0xfffffffffffffce8
>   11:	0f 0b                	ud2
>   13:	31 ff                	xor    %edi,%edi
>   15:	e9                   	.byte 0xe9
> [  130.338106][ T2674] RSP: 0018:ffffc90000ec7220 EFLAGS: 00010246
> [  130.344005][ T2674] RAX: 00000000000000f8 RBX: ffffea00086b0000 RCX:=
 ffff8883ffd08840
> [  130.351795][ T2674] RDX: 0000000000000001 RSI: 1ffffd40010d6006 RDI:=
 ffffea00086b0030
> [  130.359609][ T2674] RBP: ffff8883ffd08780 R08: 0000000000000011 R09:=
 ffff8883ffd08848
> [  130.367426][ T2674] R10: 0000000000000001 R11: 0000000000000001 R12:=
 ffffea00086b0000
> [  130.375247][ T2674] R13: 0000000000000001 R14: 0000000000001000 R15:=
 0000000000000000
> [  130.383044][ T2674] FS:  0000000000000000(0000) GS:ffff888426d45000(=
0000) knlGS:0000000000000000
> [  130.391798][ T2674] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [  130.398234][ T2674] CR2: 000055b575c2cd28 CR3: 000000043c06e004 CR4:=
 00000000003726f0
> [  130.406050][ T2674] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> [  130.413861][ T2674] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
> [  130.421668][ T2674] Call Trace:
> [  130.424805][ T2674]  <TASK>
> [ 130.427594][ T2674] ? __pfx_tcp_established_options (kbuild/obj/consu=
mer/x86_64-rhel-9.4-func/net/ipv4/tcp_output.c:989)=20
> [ 130.433409][ T2674] skb_splice_from_iter (kbuild/obj/consumer/x86_64-=
rhel-9.4-func/net/core/skbuff.c:7256)=20
> [ 130.438455][ T2674] ? __pfx_skb_splice_from_iter (kbuild/obj/consumer=
/x86_64-rhel-9.4-func/net/core/skbuff.c:7223)=20
> [ 130.444015][ T2674] ? __sk_mem_raise_allocated (kbuild/obj/consumer/x=
86_64-rhel-9.4-func/net/core/sock.c:3335)=20
> [ 130.449674][ T2674] ? __sk_mem_schedule (kbuild/obj/consumer/x86_64-r=
hel-9.4-func/net/core/sock.c:3353)=20
> [ 130.454470][ T2674] tcp_sendmsg_locked (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/net/ipv4/tcp.c:1275)=20
> [ 130.459521][ T2674] ? tcp_sendmsg (kbuild/obj/consumer/x86_64-rhel-9.=
4-func/net/ipv4/tcp.c:1370)=20
> [ 130.463786][ T2674] ? sock_sendmsg (kbuild/obj/consumer/x86_64-rhel-9=
=2E4-func/net/socket.c:712 kbuild/obj/consumer/x86_64-rhel-9.4-func/net/s=
ocket.c:727 kbuild/obj/consumer/x86_64-rhel-9.4-func/net/socket.c:750)=20
> [ 130.468307][ T2674] ? __pfx_tcp_sendmsg_locked (kbuild/obj/consumer/x=
86_64-rhel-9.4-func/net/ipv4/tcp.c:1061)=20
> [ 130.473697][ T2674] ? __pfx_sock_sendmsg (kbuild/obj/consumer/x86_64-=
rhel-9.4-func/net/socket.c:739)=20
> [ 130.478561][ T2674] ? _raw_spin_lock_bh (kbuild/obj/consumer/x86_64-r=
hel-9.4-func/arch/x86/include/asm/atomic.h:107 kbuild/obj/consumer/x86_64=
-rhel-9.4-func/include/linux/atomic/atomic-arch-fallback.h:2170 kbuild/ob=
j/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-instrumented.=
h:1302 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/asm-generic/qspin=
lock.h:111 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/spinloc=
k.h:187 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/spinlock_a=
pi_smp.h:127 kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/spin=
lock.c:178)=20
> [ 130.483350][ T2674] ? __pfx_tcp_release_cb (kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/net/ipv4/tcp_output.c:1151)=20
> [ 130.488394][ T2674] siw_tcp_sendpages+0x1f1/0x4f0 siw=20
> [ 130.494322][ T2674] ? __pfx_siw_tcp_sendpages+0x10/0x10 siw=20
> [ 130.500763][ T2674] siw_tx_hdt (kbuild/obj/consumer/x86_64-rhel-9.4-f=
unc/drivers/infiniband/sw/siw/siw_qp_tx.c:379 kbuild/obj/consumer/x86_64-=
rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:586) siw=20
> [ 130.505558][ T2674] ? __pfx_sched_balance_find_src_group (kbuild/obj/=
consumer/x86_64-rhel-9.4-func/kernel/sched/fair.c:11298)=20
> [ 130.511811][ T2674] ? __pfx_siw_tx_hdt (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:431) siw=20
> [ 130.517045][ T2674] ? sched_balance_rq (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/kernel/sched/fair.c:11770)=20
> [ 130.521998][ T2674] ? dl_scaled_delta_exec (kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/kernel/sched/deadline.c:1481)=20
> [ 130.527133][ T2674] ? place_entity (kbuild/obj/consumer/x86_64-rhel-9=
=2E4-func/kernel/sched/fair.c:5206)=20
> [ 130.531567][ T2674] ? __pfx__raw_spin_lock (kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/kernel/locking/spinlock.c:153)=20
> [ 130.536606][ T2674] ? pick_eevdf (kbuild/obj/consumer/x86_64-rhel-9.4=
-func/kernel/sched/fair.c:946)=20
> [ 130.540970][ T2674] ? __resched_curr (kbuild/obj/consumer/x86_64-rhel=
-9.4-func/arch/x86/include/asm/bitops.h:60 kbuild/obj/consumer/x86_64-rhe=
l-9.4-func/include/asm-generic/bitops/instrumented-atomic.h:29 kbuild/obj=
/consumer/x86_64-rhel-9.4-func/include/linux/thread_info.h:97 kbuild/obj/=
consumer/x86_64-rhel-9.4-func/kernel/sched/core.c:1113)=20
> [ 130.545678][ T2674] ? update_curr (kbuild/obj/consumer/x86_64-rhel-9.=
4-func/kernel/sched/fair.c:1236)=20
> [ 130.550031][ T2674] ? xas_load (kbuild/obj/consumer/x86_64-rhel-9.4-f=
unc/include/linux/xarray.h:175 kbuild/obj/consumer/x86_64-rhel-9.4-func/i=
nclude/linux/xarray.h:1264 kbuild/obj/consumer/x86_64-rhel-9.4-func/lib/x=
array.c:241)=20
> [ 130.554136][ T2674] ? xa_load (kbuild/obj/consumer/x86_64-rhel-9.4-fu=
nc/lib/xarray.c:1613)=20
> [ 130.558136][ T2674] ? __pfx_xa_load (kbuild/obj/consumer/x86_64-rhel-=
9.4-func/lib/xarray.c:1613)=20
> [ 130.562569][ T2674] ? ttwu_do_activate (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/kernel/sched/core.c:3705 kbuild/obj/consumer/x86_64-rhel-9.4-=
func/kernel/sched/core.c:3735)=20
> [ 130.567431][ T2674] ? update_rq_clock_task (kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/kernel/sched/sched.h:1325 kbuild/obj/consumer/x86_64-rhel=
-9.4-func/kernel/sched/pelt.h:120 kbuild/obj/consumer/x86_64-rhel-9.4-fun=
c/kernel/sched/core.c:797)=20
> [ 130.572650][ T2674] ? siw_mem_id2obj (kbuild/obj/consumer/x86_64-rhel=
-9.4-func/drivers/infiniband/sw/siw/siw_mem.c:52) siw=20
> [ 130.577866][ T2674] ? __pfx_siw_try_1seg (kbuild/obj/consumer/x86_64-=
rhel-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:50) siw=20
> [ 130.583264][ T2674] ? __pfx_try_to_wake_up (kbuild/obj/consumer/x86_6=
4-rhel-9.4-func/kernel/sched/core.c:4175)=20
> [ 130.588310][ T2674] ? finish_task_switch+0x155/0x750=20
> [ 130.593957][ T2674] siw_qp_sq_proc_tx (kbuild/obj/consumer/x86_64-rhe=
l-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:882) siw=20
> [ 130.599352][ T2674] ? siw_activate_tx (kbuild/obj/consumer/x86_64-rhe=
l-9.4-func/drivers/infiniband/sw/siw/siw_qp.c:996) siw=20
> [ 130.604670][ T2674] siw_qp_sq_process (kbuild/obj/consumer/x86_64-rhe=
l-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1038) siw=20
> [ 130.609905][ T2674] siw_sq_resume (kbuild/obj/consumer/x86_64-rhel-9.=
4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1170) siw=20
> [ 130.614789][ T2674] siw_run_sq (kbuild/obj/consumer/x86_64-rhel-9.4-f=
unc/drivers/infiniband/sw/siw/siw_qp_tx.c:1258) siw=20
> [ 130.619508][ T2674] ? __pfx_siw_run_sq (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1236) siw=20
> [ 130.624735][ T2674] ? __pfx__raw_spin_lock_irqsave (kbuild/obj/consum=
er/x86_64-rhel-9.4-func/kernel/locking/spinlock.c:161)=20
> [ 130.630482][ T2674] ? __pfx_autoremove_wake_function (kbuild/obj/cons=
umer/x86_64-rhel-9.4-func/kernel/sched/wait.c:383)=20
> [ 130.636383][ T2674] ? __kthread_parkme (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/arch/x86/include/asm/bitops.h:206 (discriminator 15) kbuild/o=
bj/consumer/x86_64-rhel-9.4-func/arch/x86/include/asm/bitops.h:238 (discr=
iminator 15) kbuild/obj/consumer/x86_64-rhel-9.4-func/include/asm-generic=
/bitops/instrumented-non-atomic.h:142 (discriminator 15) kbuild/obj/consu=
mer/x86_64-rhel-9.4-func/kernel/kthread.c:291 (discriminator 15))=20
> [ 130.641160][ T2674] ? __pfx_siw_run_sq (kbuild/obj/consumer/x86_64-rh=
el-9.4-func/drivers/infiniband/sw/siw/siw_qp_tx.c:1236) siw=20
> [ 130.646377][ T2674] kthread (kbuild/obj/consumer/x86_64-rhel-9.4-func=
/kernel/kthread.c:464)=20
> [ 130.650291][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-=
9.4-func/kernel/kthread.c:413)=20
> [ 130.654724][ T2674] ? __pfx__raw_spin_lock_irq (kbuild/obj/consumer/x=
86_64-rhel-9.4-func/kernel/locking/spinlock.c:169)=20
> [ 130.660098][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-=
9.4-func/kernel/kthread.c:413)=20
> [ 130.664534][ T2674] ret_from_fork (kbuild/obj/consumer/x86_64-rhel-9.=
4-func/arch/x86/kernel/process.c:159)=20
> [ 130.668809][ T2674] ? __pfx_kthread (kbuild/obj/consumer/x86_64-rhel-=
9.4-func/kernel/kthread.c:413)=20
> [ 130.673247][ T2674] ret_from_fork_asm (kbuild/obj/consumer/x86_64-rhe=
l-9.4-func/arch/x86/entry/entry_64.S:258)=20
> [  130.677869][ T2674]  </TASK>
> [  130.680755][ T2674] ---[ end trace 0000000000000000 ]---
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250522/202505221248.595a9117-=
lkp@intel.com
>=20
>=20
>=20


