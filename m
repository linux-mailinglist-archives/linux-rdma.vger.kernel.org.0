Return-Path: <linux-rdma+bounces-14755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE211C83DD5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681723A12ED
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432002DBF76;
	Tue, 25 Nov 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="TESA7wlN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800A137C52;
	Tue, 25 Nov 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057743; cv=none; b=LP9hy87nrh++9G8gR9imholPUl+G3NddWB3w8Pa/lhw6JsH2/w1cyIDbZ+L4CqT+0/ua3h9w+RRWK8HFtdyG1cVhiA1UjmJrlhDaP2iEL8IRkiuZPAPqvDD6LNjTT3IWd1wnll8g+pgLv/p7E+f93On0OUaTR24fTU2Lx1j1F9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057743; c=relaxed/simple;
	bh=WcIbzYoT9xf7AHSCL58Dc30ZPv/9EyJg71UrKYk4W1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOnVmzByKb0JxqMgdLXucFxdRB8WmbKuZ/yQsbl5OaF2t3mFAoKHUaQGQjMOzKhwzCszkhShNmtCj4rn1CLBCnP0qC+koLP2FmONAQsY7bI4uuuk58fOJqCbBEU9AF/HlzGPASKm9hqtSDIAwBZ7myDemoO1csVvEyg6KgBLm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=TESA7wlN; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=zQTS2A1rQ1kCDqlhToS3EJo6iLjNSKezK7MLz88BmtM=; b=TESA7wlN40tZ3oe6Ar+EE7KlVH
	lqUPD6ipgEhqSZ1/eivFb+skCav+NneLoD+kCDFY6ziDWVIVtIVJYXj7ddK7dadtobEMZCstuCtim
	1Vg7Ex2Z38Peedo5ARvWokk3/yM3BLZQ0R7Js4sCkl1aRh00W16Qh+NJqYsNzbFXm8z35LCkPr24K
	9qU5X1uyevQTeIYmnO9A8z0wQVMxWc9fwzDPcOYCKsILwqr9GkXqd4jLGftRuvK/5lLaKfWMsN5so
	VlW6vftXsI8lyKjG2NldYHUbt44NMKSZsV7mcWApmLTmlJehcte1LeSc1f00sFNG1jOkEAhrrW3fv
	l9MkSGt12C86qeYiFBKnB6RN7TzzFKN6hbAaKPefR+BtR5F9XsAZZ0Sf6qhOEV4fZk4xuABodvD3u
	boqf8IuIEh1gXHh/7ZcfQQZNJtj1wX2sm4bgE775qjiq3oJkK2l5djyHQFNuyLvkQSVyIr/CDDMZU
	BiqMGecTgWvf5PhaBuXbO01P;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vNo09-00FXy6-1u;
	Tue, 25 Nov 2025 08:02:17 +0000
Message-ID: <d1469a01-60c7-427b-aec2-038a38ddba0a@samba.org>
Date: Tue, 25 Nov 2025 09:02:17 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] smb: server: relax WARN_ON_ONCE(SMBDIRECT_SOCKET_*)
 checks in recv_done() and smb_direct_cm_handler()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Long Li <longli@microsoft.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <cover.1764016346.git.metze@samba.org>
 <b15108255ca908620251451408b14f3bfadf5e8d.1764016346.git.metze@samba.org>
 <CAKYAXd-F=cOfBLi69QdTfTqU4ggXcAGZ3wVMrXur18=c5XOUMw@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd-F=cOfBLi69QdTfTqU4ggXcAGZ3wVMrXur18=c5XOUMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.11.25 um 02:48 schrieb Namjae Jeon:
> On Tue, Nov 25, 2025 at 5:42 AM Stefan Metzmacher <metze@samba.org> wrote:
>>
>> Namjae reported the following:
>>
>> I have a simple file copy test with windows 11 client, and get the
>> following error message.
>>
>> [  894.140312] ------------[ cut here ]------------
>> [  894.140316] WARNING: CPU: 1 PID: 116 at
>> fs/smb/server/transport_rdma.c:642 recv_done+0x308/0x360 [ksmbd]
>> [  894.140335] Modules linked in: ksmbd cmac nls_utf8 nls_ucs2_utils
>> libarc4 nls_iso8859_1 snd_hda_codec_intelhdmi snd_hda_codec_hdmi
>> snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic
>> rpcrdma intel_rapl_msr rdma_ucm intel_rapl_common snd_hda_intel
>> ib_iser snd_hda_codec intel_uncore_frequency
>> intel_uncore_frequency_common snd_hda_core intel_tcc_cooling
>> x86_pkg_temp_thermal intel_powerclamp snd_intel_dspcfg libiscsi
>> snd_intel_sdw_acpi coretemp scsi_transport_iscsi snd_hwdep kvm_intel
>> i915 snd_pcm ib_umad rdma_cm snd_seq_midi ib_ipoib kvm
>> snd_seq_midi_event iw_cm snd_rawmidi ghash_clmulni_intel ib_cm
>> aesni_intel snd_seq mei_hdcp drm_buddy rapl snd_seq_device eeepc_wmi
>> asus_wmi snd_timer intel_cstate ttm snd drm_client_lib
>> drm_display_helper sparse_keymap soundcore platform_profile mxm_wmi
>> wmi_bmof joydev mei_me cec acpi_pad mei rc_core drm_kms_helper
>> input_leds i2c_algo_bit mac_hid sch_fq_codel msr parport_pc ppdev lp
>> nfsd parport auth_rpcgss binfmt_misc nfs_acl lockd grace drm sunrpc
>> ramoops efi_pstore
>> [  894.140414]  reed_solomon pstore_blk pstore_zone autofs4 btrfs
>> blake2b_generic xor raid6_pq mlx5_ib ib_uverbs ib_core hid_generic uas
>> usbhid hid r8169 i2c_i801 usb_storage i2c_mux i2c_smbus mlx5_core
>> realtek ahci mlxfw psample libahci video wmi [last unloaded: ksmbd]
>> [  894.140442] CPU: 1 UID: 0 PID: 116 Comm: kworker/1:1H Tainted: G
>>      W           6.18.0-rc5+ #1 PREEMPT(voluntary)
>> [  894.140447] Tainted: [W]=WARN
>> [  894.140448] Hardware name: System manufacturer System Product
>> Name/H110M-K, BIOS 3601 12/12/2017
>> [  894.140450] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>> [  894.140476] RIP: 0010:recv_done+0x308/0x360 [ksmbd]
>> [  894.140487] Code: 2e f2 ff ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc
>> cc cc cc 41 8b 55 10 49 8b 75 08 b9 02 00 00 00 e8 ed f4 f2 c3 e9 59
>> fd ff ff <0f> 0b e9 02 ff ff ff 49 8b 74 24 28 49 8d 94 24 c8 00 00 00
>> bf 00
>> [  894.140490] RSP: 0018:ffffa47ec03f3d78 EFLAGS: 00010293
>> [  894.140492] RAX: 0000000000000001 RBX: ffff8eb84c818000 RCX: 000000010002ba00
>> [  894.140494] RDX: 0000000037600001 RSI: 0000000000000083 RDI: ffff8eb92ec9ee40
>> [  894.140496] RBP: ffffa47ec03f3da0 R08: 0000000000000000 R09: 0000000000000010
>> [  894.140498] R10: ffff8eb801705680 R11: fefefefefefefeff R12: ffff8eb7454b8810
>> [  894.140499] R13: ffff8eb746deb988 R14: ffff8eb746deb980 R15: ffff8eb84c818000
>> [  894.140501] FS:  0000000000000000(0000) GS:ffff8eb9a7355000(0000)
>> knlGS:0000000000000000
>> [  894.140503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  894.140505] CR2: 00002d9401d60018 CR3: 0000000010a40006 CR4: 00000000003726f0
>> [  894.140507] Call Trace:
>> [  894.140509]  <TASK>
>> [  894.140512]  __ib_process_cq+0x8e/0x190 [ib_core]
>> [  894.140530]  ib_cq_poll_work+0x2f/0x90 [ib_core]
>> [  894.140545]  process_scheduled_works+0xd4/0x430
>> [  894.140554]  worker_thread+0x12a/0x270
>> [  894.140558]  kthread+0x10d/0x250
>> [  894.140564]  ? __pfx_worker_thread+0x10/0x10
>> [  894.140567]  ? __pfx_kthread+0x10/0x10
>> [  894.140571]  ret_from_fork+0x11a/0x160
>> [  894.140574]  ? __pfx_kthread+0x10/0x10
>> [  894.140577]  ret_from_fork_asm+0x1a/0x30
>> [  894.140584]  </TASK>
>> [  894.140585] ---[ end trace 0000000000000000 ]---
>> [  894.154363] ------------[ cut here ]------------
>> [  894.154367] WARNING: CPU: 3 PID: 5543 at
>> fs/smb/server/transport_rdma.c:1728 smb_direct_cm_handler+0x121/0x130
>> [ksmbd]
>> [  894.154384] Modules linked in: ksmbd cmac nls_utf8 nls_ucs2_utils
>> libarc4 nls_iso8859_1 snd_hda_codec_intelhdmi snd_hda_codec_hdmi
>> snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic
>> rpcrdma intel_rapl_msr rdma_ucm intel_rapl_common snd_hda_intel
>> ib_iser snd_hda_codec intel_uncore_frequency
>> intel_uncore_frequency_common snd_hda_core intel_tcc_cooling
>> x86_pkg_temp_thermal intel_powerclamp snd_intel_dspcfg libiscsi
>> snd_intel_sdw_acpi coretemp scsi_transport_iscsi snd_hwdep kvm_intel
>> i915 snd_pcm ib_umad rdma_cm snd_seq_midi ib_ipoib kvm
>> snd_seq_midi_event iw_cm snd_rawmidi ghash_clmulni_intel ib_cm
>> aesni_intel snd_seq mei_hdcp drm_buddy rapl snd_seq_device eeepc_wmi
>> asus_wmi snd_timer intel_cstate ttm snd drm_client_lib
>> drm_display_helper sparse_keymap soundcore platform_profile mxm_wmi
>> wmi_bmof joydev mei_me cec acpi_pad mei rc_core drm_kms_helper
>> input_leds i2c_algo_bit mac_hid sch_fq_codel msr parport_pc ppdev lp
>> nfsd parport auth_rpcgss binfmt_misc nfs_acl lockd grace drm sunrpc
>> ramoops efi_pstore
>> [  894.154456]  reed_solomon pstore_blk pstore_zone autofs4 btrfs
>> blake2b_generic xor raid6_pq mlx5_ib ib_uverbs ib_core hid_generic uas
>> usbhid hid r8169 i2c_i801 usb_storage i2c_mux i2c_smbus mlx5_core
>> realtek ahci mlxfw psample libahci video wmi [last unloaded: ksmbd]
>> [  894.154483] CPU: 3 UID: 0 PID: 5543 Comm: kworker/3:6 Tainted: G
>>      W           6.18.0-rc5+ #1 PREEMPT(voluntary)
>> [  894.154487] Tainted: [W]=WARN
>> [  894.154488] Hardware name: System manufacturer System Product
>> Name/H110M-K, BIOS 3601 12/12/2017
>> [  894.154490] Workqueue: ib_cm cm_work_handler [ib_cm]
>> [  894.154499] RIP: 0010:smb_direct_cm_handler+0x121/0x130 [ksmbd]
>> [  894.154507] Code: e7 e8 13 b1 ef ff 44 89 e1 4c 89 ee 48 c7 c7 80
>> d7 59 c1 48 89 c2 e8 2e 4d ef c3 31 c0 5b 41 5c 41 5d 41 5e 5d c3 cc
>> cc cc cc <0f> 0b eb a5 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
>> 90 90
>> [  894.154510] RSP: 0018:ffffa47ec1b27c00 EFLAGS: 00010206
>> [  894.154512] RAX: ffffffffc1304e00 RBX: ffff8eb89ae50880 RCX: 0000000000000000
>> [  894.154514] RDX: ffff8eb730960000 RSI: ffffa47ec1b27c60 RDI: ffff8eb7454b9400
>> [  894.154515] RBP: ffffa47ec1b27c20 R08: 0000000000000002 R09: ffff8eb730b8c18b
>> [  894.154517] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000009
>> [  894.154518] R13: ffff8eb7454b9400 R14: ffff8eb7454b8810 R15: ffff8eb815c43000
>> [  894.154520] FS:  0000000000000000(0000) GS:ffff8eb9a7455000(0000)
>> knlGS:0000000000000000
>> [  894.154522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  894.154523] CR2: 00007fe1310e99d0 CR3: 0000000010a40005 CR4: 00000000003726f0
>> [  894.154525] Call Trace:
>> [  894.154527]  <TASK>
>> [  894.154530]  cma_cm_event_handler+0x27/0xd0 [rdma_cm]
>> [  894.154541]  cma_ib_handler+0x99/0x2e0 [rdma_cm]
>> [  894.154551]  cm_process_work+0x28/0xf0 [ib_cm]
>> [  894.154557]  cm_queue_work_unlock+0x41/0xf0 [ib_cm]
>> [  894.154563]  cm_work_handler+0x2eb/0x25b0 [ib_cm]
>> [  894.154568]  ? pwq_activate_first_inactive+0x52/0x70
>> [  894.154572]  ? pwq_dec_nr_in_flight+0x244/0x330
>> [  894.154575]  process_scheduled_works+0xd4/0x430
>> [  894.154579]  worker_thread+0x12a/0x270
>> [  894.154581]  kthread+0x10d/0x250
>> [  894.154585]  ? __pfx_worker_thread+0x10/0x10
>> [  894.154587]  ? __pfx_kthread+0x10/0x10
>> [  894.154590]  ret_from_fork+0x11a/0x160
>> [  894.154593]  ? __pfx_kthread+0x10/0x10
>> [  894.154596]  ret_from_fork_asm+0x1a/0x30
>> [  894.154602]  </TASK>
>> [  894.154603] ---[ end trace 0000000000000000 ]---
>> [  894.154931] ksmbd: smb_direct: disconnected
>> [  894.157278] ksmbd: smb_direct: disconnected
>>
>> I guess sc->first_error is already set and sc->status
>> is thus unexpected, so this should avoid the WARN[_ON]_ONCE()
>> if sc->first_error is already set and have a usable error path.
>>
>> While there set sc->first_error as soon as possible.
>>
>> Fixes: e2d5e516c663 ("smb: server: only turn into SMBDIRECT_SOCKET_CONNECTED when negotiation is done")
>> Cc: Steve French <smfrench@gmail.com>
>> Cc: Tom Talpey <tom@talpey.com>
>> Cc: Long Li <longli@microsoft.com>
>> Cc: Namjae Jeon <linkinjeon@kernel.org>
>> Cc: linux-cifs@vger.kernel.org
>> Cc: samba-technical@lists.samba.org
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> ---
>>   fs/smb/server/transport_rdma.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
>> index e2be9a496154..97b6f68dbf8e 100644
>> --- a/fs/smb/server/transport_rdma.c
>> +++ b/fs/smb/server/transport_rdma.c
>> @@ -231,6 +231,9 @@ static void smb_direct_disconnect_rdma_work(struct work_struct *work)
>>          struct smbdirect_socket *sc =
>>                  container_of(work, struct smbdirect_socket, disconnect_work);
>>
>> +       if (sc->first_error == 0)
>> +               sc->first_error = -ECONNABORTED;
>> +
>>          /*
>>           * make sure this and other work is not queued again
>>           * but here we don't block and avoid
>> @@ -241,9 +244,6 @@ static void smb_direct_disconnect_rdma_work(struct work_struct *work)
>>          disable_delayed_work(&sc->idle.timer_work);
>>          disable_work(&sc->idle.immediate_work);
>>
>> -       if (sc->first_error == 0)
>> -               sc->first_error = -ECONNABORTED;
>> -
>>          switch (sc->status) {
>>          case SMBDIRECT_SOCKET_NEGOTIATE_NEEDED:
>>          case SMBDIRECT_SOCKET_NEGOTIATE_RUNNING:
>> @@ -284,9 +284,13 @@ static void smb_direct_disconnect_rdma_work(struct work_struct *work)
>>          smb_direct_disconnect_wake_up_all(sc);
>>   }
>>
>> +#define __SMBDIRECT_SOCKET_DISCONNECT(__sc) smb_direct_disconnect_rdma_connection(__sc)
>>   static void
>>   smb_direct_disconnect_rdma_connection(struct smbdirect_socket *sc)
>>   {
>> +       if (sc->first_error == 0)
>> +               sc->first_error = -ECONNABORTED;
>> +
>>          /*
>>           * make sure other work (than disconnect_work) is
>>           * not queued again but here we don't block and avoid
>> @@ -296,9 +300,6 @@ smb_direct_disconnect_rdma_connection(struct smbdirect_socket *sc)
>>          disable_work(&sc->idle.immediate_work);
>>          disable_delayed_work(&sc->idle.timer_work);
>>
>> -       if (sc->first_error == 0)
>> -               sc->first_error = -ECONNABORTED;
>> -
>>          switch (sc->status) {
>>          case SMBDIRECT_SOCKET_RESOLVE_ADDR_FAILED:
>>          case SMBDIRECT_SOCKET_RESOLVE_ROUTE_FAILED:
>> @@ -639,7 +640,11 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
>>                          return;
>>                  }
>>                  sc->recv_io.reassembly.full_packet_received = true;
>> -               WARN_ON_ONCE(sc->status != SMBDIRECT_SOCKET_NEGOTIATE_NEEDED);
>> +               if (SMBDIRECT_CHECK_STATUS_WARN(sc, SMBDIRECT_SOCKET_NEGOTIATE_NEEDED)) {
>> +                       put_recvmsg(sc, recvmsg);
>> +                       smb_direct_disconnect_rdma_connection(sc);
>> +                       return;
>> +               }
> This will result in the following warning...
> 
> [  309.560964] ------------[ cut here ]------------
> [  309.560973] expected[NEGOTIATE_NEEDED] != RDMA_CONNECT_RUNNING
> first_error=0 local=192.168.0.200:445 remote=192.168.0.100:60445
> [  309.561034] WARNING: CPU: 2 PID: 78 at transport_rdma.c:643
> recv_done+0x2fa/0x3d0 [ksmbd]

Ok, it seems that the melanox driver (and maye others)
call a recv completion before RDMA_CM_EVENT_ESTABLISHED
arrives after rdma_accept.

I'll adjust the code to allow that...

Thanks for testing!
metze

