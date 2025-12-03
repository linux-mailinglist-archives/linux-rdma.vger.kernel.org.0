Return-Path: <linux-rdma+bounces-14873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E6CA0E0B
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 19:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E8D300A2AE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0C306B2E;
	Wed,  3 Dec 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="N5T71W+O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA335274658;
	Wed,  3 Dec 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785918; cv=none; b=oGLWctiJ3hLAJ8nF/SVPaUWZLPPReOPyt4dx1gF+e7RlUPt2lXTxBH7YHGTFTfnjizBP/ijKm8BuuB+/jmXg6shfaQ3WPo/0M9rW0VN7uZL7FS0OOiE48BPKJXx/EynzQowyuDOWOMXTcsrfqouDRmm7Jmxq3Cd6TwEW8P26xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785918; c=relaxed/simple;
	bh=hbAYP3r5Mc8rBGU7W8VttBkj22/9LAAVAUjCF/9VK5c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H3jgZko6EPnr/c91CLAp90Y1XJ2t8lGXPuA9kSTMVAD+e60TMWgKlFI9so8En9iYJM0n58KUvZYiDFVd9uhq2PyulhC3zyFAo42LY6Q3vVO5z9/iCNzghIvPH0z4ZulYC3qTgm8dvglvHWtRD78IXgRmoJdu9He9edlvt9/0Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=N5T71W+O; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=/AcU12eHhR/9X7R00vtfR14efmupqHLbJmjtNundrMg=; b=N5T71W+O5rt7M25YpfrDrPAdCG
	MWvqkseWOlTu+3Ygk/7p+NrDRS4BPnyQKWvJdHBCTEgUeXl7BCzaLbA5Yo2tepp/ZHpAu66+6pBmx
	qqCo9MyeIOecDE6SELE6fvpR71LDlVtEA6TPmF/52oNx78HrEhJtGjuJj06uYndPCFlHb3X75hn4G
	VNDSJWcvQGPW4OgAcBz81QY2sutZRP+m9YO2fOXNMsMJ00CyJdPDpyy4R8ziSZ2ycB97sc1nLP1NT
	J6PNWPqJrF2lfS26pFCmkICBnwwEEAKJR4gs4R4nKHIXOFvtlixGRmOiLOHa/U3z6NZKu16ZEx5jx
	YyTtgz5kNK4tavXf9+E7vTvWr9iD+aod/H3miCahM3UMXi7PkXpzPLsVggW/W7CiMzYwQNBuW9CZN
	VeZTwesX36RQOjO22jmKc4DCxcHv29N5p7PXEiKmAO4AwpxtSnoTcpGylI/XSUJUEc2nLrgSx05OL
	8rMg7HayeNJHFdsKf4KK75wn;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vQrQu-00Gqnx-1W;
	Wed, 03 Dec 2025 18:18:32 +0000
Message-ID: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
Date: Wed, 3 Dec 2025 19:18:31 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From: Stefan Metzmacher <metze@samba.org>
Subject: Problem with smbdirect rw credits and initiator_depth
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namjae,

I found the problem why the 6.17.9 code of transport_rdma.c deadlocks
with a Windows client, when using irdma in roce mode, while the 6.18
code works fine.

irdma/roce in 6.17.9 code => deadlock in wait_for_rw_credits()
[   T8653] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:16
[   T8653] ksmbd: smb_direct: max_rw_credits:9
[   T7013] ------------[ cut here ]------------
[   T7013] needed:31 > max:9
[   T7013] WARNING: CPU: 1 PID: 7013 at transport_rdma.c:975 wait_for_credits+0x3b8/0x430 [ksmbd]

When the client starts to send an array with larger number of smb2_buffer_desc_v1
elements in a single SMB2 write request (most likely 31 in the above example)
wait_for_rw_credits() will simply deadlock, as there are only 9 credits possible
and 31 are requested.

In the 6.18 code we have commit 0bd73ae09ba1b73137d0830b21820d24700e09b1
smb: server: allocate enough space for RW WRs and ib_drain_qp()

It makes sure we allocate qp_attr.cap.max_rdma_ctxs and qp_attr.cap.max_send_wr
correct. qp_attr.cap.max_rdma_ctxs was filled by sc->rw_io.credits.max before,
so I changed sc->rw_io.credits.max, but that might need to be split from
each other.

But after that change we no longer deadlock when the client starts sending
larger SMB2 writes, with a larger number of smb2_buffer_desc_v1 elements
it no longer deadlocks, 159 more than enough.

irdma/roce:
[   T6505] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:16
...
[   T6505] ksmbd: smb_direct: sc->rw_io.credits.num_pages=13 sc->rw_io.credits.max:159

My current theory about the Mellanox problem is, that the number of pending
RDMA Read operations should be limited by the negotiated initiator_depth, which is at max
SMB_DIRECT_CM_INITIATOR_DEPTH (8). And we're overflowing the hardware limits by
posting too much RDMA Read sqes.

The change in 0bd73ae09ba1b73137d0830b21820d24700e09b1 didn't change the
resulting values of sc->rw_io.credits.max for iwarp devices, it only adjusted
the number for qp_attr.cap.max_send_wr.

So for iwarp we deadlock in both versions of transport_rdma.c, when
the client starts to send an array of 17 of smb2_buffer_desc_v1 elements
(I was able to see that using siw on the server, so that tcpdump was
able to capture it, see:
https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025-12-03/rdma1-siw-r6.18-ace-fixed-hang-01-stream13.pcap.gz
With roce it's directly using 17:
https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025-12-03/rdma1-rxe-r6.18-race-fixed-rw-credits-reverted-hang-01.pcap.gz

The first few SMB2 writes use 2 smb2_buffer_desc_v1 elements and at the end
the Windows client switches to 17 smb2_buffer_desc_v1 elements.

irdma/iwarp:
[Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:127
..
[Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256 sc->rw_io.credits.max:9
...
[Wed Dec  3 13:45:22 2025] [   T8638] ------------[ cut here ]------------
[Wed Dec  3 13:45:22 2025] [   T8638] needed:17 > max:9


siw/iwarp:
[Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:16
...
[Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256 sc->rw_io.credits.max:9
...
[Wed Dec  3 13:49:30 2025] [   T9353] ------------[ cut here ]------------
[Wed Dec  3 13:49:30 2025] [   T9353] needed:17 > max:9

I've prepared 3 branches for testing:

for-6.18/ksmbd-smbdirect-regression-v1
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/for-6.18/ksmbd-smbdirect-regression-v1

This has some pr_notice() messages and a WARN_ONCE() when the wait_for_rw_credits() happens.

for-6.18/ksmbd-smbdirect-regression-v2
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/for-6.18/ksmbd-smbdirect-regression-v2

This is based on for-6.18/ksmbd-smbdirect-regression-v1 but reverts
commit 0bd73ae09ba1b73137d0830b21820d24700e09b1, this might fix your setup.

for-6.18/ksmbd-smbdirect-regression-v3
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/for-6.18/ksmbd-smbdirect-regression-v3

This reverts everything to the state of v6.17.9 +
This has some pr_notice() messages and a WARN_ONCE() when the wait_for_rw_credits() happens.

Can you please test them with the priority of testing
for-6.18/ksmbd-smbdirect-regression-v2 first and the others if you have
more time.

I typically use this running on a 6.18 kernel:
modprobe ksmbd
ksmbd.control -s
rmmod ksmbd
cd fs/smb/server
make -j$(getconf _NPROCESSORS_ONLN) -C /lib/modules/$(uname -r)/build M=$(pwd) KBUILD_MODPOST_WARN=1 modules
insmod ksmbd.ko
ksmbd.mountd

The in one window:
bpftrace -e 'kprobe:smb_direct_rdma_xmit { printf("%s: %s pid=%d %s\n", strftime("%F %H:%M:%S", nsecs(sw_tai)), comm, pid, func); }'
And in another window:
dmesg -T -w


I assume the solution is to change smb_direct_rdma_xmit, so that
it doesn't try to get credits for all RDMA read/write requests at once.
Instead after collecting all ib_send_wr structures from all rdma_rw_ctx_wrs()
we chunk the list to stay in the negotiated initiator depth,
before passing to ib_post_send().

At least we need to limit this for RDMA read requests, for RDMA write requests
we may not need to chunk and post them all together, but still chunking might
be good in order to avoid blocking concurrent RDMA sends.

Tom is this assumption correct?

Thanks!
metze


