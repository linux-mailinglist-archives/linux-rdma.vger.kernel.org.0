Return-Path: <linux-rdma+bounces-21432-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBF/Net4GGo8kQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21432-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:18:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 954275F5849
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB2BA3067819
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889C3FAE08;
	Thu, 28 May 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb6tibzU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E452F6565
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987892; cv=none; b=Twx20W8VnyuLRozdT9w3zJ8n2KwNopi9Kk+4D9FINDB1OiPqaLLFWmEODGGs7z1k1mREq8KXefuMVT0rJKgPPPMlF5OlOZmcTVXRttaFLcotjNJvIKeM+58DtBOyt7KQW7GoAOWbLIzlEyX7WshfB5pZZDHhJ4cwWo5dkBaa28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987892; c=relaxed/simple;
	bh=kOHe2QUTHD+mFExERu5r4+hz2wPW3d+FJkflRwKHtYA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uAKiud89u9WiziurbZ378+SXaztybXc/rDHFjClZtQTWV5i2jR+ZIw2flHvddFTR4G5GwGNH16GcbuJkc2rdbbLzOt+3Uuke/oOn8u5XYyavltjhrBhs+flPvbD542gxBrRWQePPgH4EppazYejsYryuj0cOruLp8dDuxvNrUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb6tibzU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so11254876d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779987889; x=1780592689; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVvKmQSUVNcPGnpeO8ALn7LkyX+WnGR/CwcsH9fvnZM=;
        b=Nb6tibzUAr2B8xnx/A50B+Y+uJrRYWVnKIEIVm2/WLA1I+Z+EGsip79XoTPq8l0GIx
         pRIYcLwiZ4ACXDrGIix/7ANUGykGRcM70dWpTjpUf+GYSEVjWZCEJqtN2EXEiFopzYlC
         rGZ/PQrXbBJWExkUPRD9p6UcKogrrBRXlm+qN9xXAwSAMw4xMZIqVkOLt78sEtuz3lO5
         J3NIm2L8/c4pFqYlyboHIAV41qoOLH4bUbr6uolCAXG5MaibmTDjziL3xzCZMEXO+UAK
         W97lLyvLKyWlbcNZkGhzWM9vCbdErbNfY5QhvswFtUbXWD8JKjSpYMm04i30t4BB2JZ8
         t63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987889; x=1780592689;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVvKmQSUVNcPGnpeO8ALn7LkyX+WnGR/CwcsH9fvnZM=;
        b=rjZTMRqwQoYXL9xfyaifszFyKrnkyNiJiV7XFiOQGIRLveJan5DkuwxP+EhXMY4RUS
         PvWVbd4vK5IyYMHg/GsvyhrVrVqw2+DLCNedK1YNFX8L/J5J5UpZcT/Cv0nX9A30Vz5w
         CUYthxQWNp3NNPyDVF9zitUSxuKs0hRHzWdCqRJWASFMk62NRua0gHl5YFlQu6mbe0hZ
         MxyORM1R1fZO6viwWo6w3+fGyzFEy9QOI1mSL056FHpX5svdK37PmG+kJz+ATmmSimuS
         5D32ITPKuwlhcF+vSNT7nci0u9y1VBkTgXkPKIiiiDZy8md/CmtGIcS5RUwoG1lzz3Si
         uJ5w==
X-Forwarded-Encrypted: i=1; AFNElJ+L3dbHa3ELzquKY348jynDrLIhRJlpu2jbUBd+G2dWdlnEHfhZpSJ0sYa2afnv3zF5rtrlncpvF+pn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4scPi6rvUe8NSnpqsIuCeYibi3EFtnQntBloQ0UUGlx7VsK9S
	XmLAVcaBQCA2VgutIOF3XdzPhgerciREJgLS0FzMK0e9dCg3gNiqTiOQ
X-Gm-Gg: Acq92OFKvIuUNoLvJ0hBL5UP2+xOLJkqv5nzKuo3fDxWjl54anooa/kEPrxisY4q2tV
	wQQGMvlFM4srfeffBhYP90qVavARK2ojIftBGOBWcTkRg/8WhZIqgw8xBpDJmvANg5A0BFPNh26
	WiOoSxn9L4bCJ8lkBeP3iI7W762XRTACuZzcdXn0xEPlmxhQCOwtUVpoY7npqbzAy3NGBK3m+fs
	bDzzH1Rtot4ucqSGk3ETgMW9fVXabV8ubNya7/8yCNu5k0UeENCZ0jIk4j5uYqiI5KHyW1LC2Ti
	NvdoIdtTTcLYznpbXLW/R7/fDbTXVpjwFDROVOnImnShLuuzh6UzxRmgvsKfJgVHLbbjup70Ayn
	qkPr0ohJuSSKnIM37PmEAQqe3lDCrm01Az+4+1tatwRa/4J2aZ2V1ff8vOQ2fCEQphEYT06Hqol
	INJ7XNkHCuW/2/tSD5hCAgR31uDkWpeu/VA67tPjefYLTXii6lN01ZWZEvGrVNloxe
X-Received: by 2002:a05:6214:419e:b0:8ac:ae66:8eb9 with SMTP id 6a1803df08f44-8cc7b5dbc35mr458058886d6.46.1779987888752;
        Thu, 28 May 2026 10:04:48 -0700 (PDT)
Received: from smtpclient.apple ([104.39.165.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm227722756d6.24.2026.05.28.10.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2026 10:04:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in siw_cm_work_handler
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <94d830ba-a8ec-4505-84e0-947a930ccf0a@linux.dev>
Date: Thu, 28 May 2026 13:04:37 -0400
Cc: jgg@ziepe.ca,
 leon@kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <143D58FD-E3E8-4B1D-B33B-D1117C38CB0A@gmail.com>
References: <FFC7BFD6-EDB5-49AE-ACB5-A2F940D8F687@gmail.com>
 <94d830ba-a8ec-4505-84e0-947a930ccf0a@linux.dev>
To: Bernard Metzler <bernard.metzler@linux.dev>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21432-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 954275F5849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the update.
If there is anything else I can help with on my side, feel free to let =
me know.

Best,
Shuangpeng

> On May 28, 2026, at 06:02, Bernard Metzler <bernard.metzler@linux.dev> =
wrote:
>=20
> On 28.05.2026 05:52, Shuangpeng wrote:
>> Hi Kernel Maintainers,
>> I hit the following KASAN report while testing current upstream =
kernel:
>> KASAN: slab-use-after-free in siw_cm_work_handler
>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>> The reproducer, detailed document, and .config files are here:
>> =
https://gist.github.com/shuangpengbai/f8a60ffa1b95c54672433bd9ee82e8ce
>> I=E2=80=99m happy to test debug patches or provide additional =
information.
>=20
> Thanks Shuangpeng, I will look at it next week.
> I am currently travelling w/o access to any
> development environment.
>=20
> Thanks for reporting!
> Bernard.
>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> [   60.059964][  T817] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   60.060980][  T817] BUG: KASAN: slab-use-after-free in =
siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
>> [   60.062008][  T817] Write of size 8 at addr ffff888170c8ac70 by =
task kworker/u8:1/817
>> [   60.063033][  T817]
>> [   60.063347][  T817] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+ PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   60.063350][  T817] Workqueue: siw_cm_wq siw_cm_work_handler
>> [   60.063356][  T817] Call Trace:
>> [   60.063359][  T817]  <TASK>
>> [   60.063361][  T817]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
>> [   60.063369][  T817]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
>> [   60.063385][  T817]  kasan_report (mm/kasan/report.c:595)
>> [   60.063399][  T817]  siw_cm_work_handler =
(drivers/infiniband/sw/siw/siw_cm.c:1053 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
>> [   60.063472][  T817]  process_scheduled_works =
(kernel/workqueue.c:3314 kernel/workqueue.c:3397)
>> [   60.063477][  T817]  worker_thread (kernel/workqueue.c:3478)
>> [   60.063484][  T817]  kthread (kernel/kthread.c:436)
>> [   60.063495][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
>> [   60.063511][  T817]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
>> [   60.063515][  T817]  </TASK>
>> [   60.063516][  T817]
>> [   60.087529][  T817] Freed by task 817 on cpu 1 at 60.059899s:
>> [   60.088264][  T817]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
>> [   60.088821][  T817]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [   60.089385][  T817]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
>> [   60.089940][  T817]  kfree (./include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
>> [   60.090383][  T817]  siw_cm_work_handler =
(drivers/infiniband/sw/siw/siw_cm.c:141 =
drivers/infiniband/sw/siw/siw_cm.c:1051 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
>> [   60.090979][  T817]  process_scheduled_works =
(kernel/workqueue.c:3314 kernel/workqueue.c:3397)
>> [   60.091616][  T817]  worker_thread (kernel/workqueue.c:3478)
>> [   60.092191][  T817]  kthread (kernel/kthread.c:436)
>> [   60.092637][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
>> [   60.093226][  T817]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
>> [   60.093782][  T817]
>> [   60.094033][  T817] The buggy address belongs to the object at =
ffff888170c8ac00
>> [   60.094033][  T817]  which belongs to the cache kmalloc-256 of =
size 256
>> [   60.095541][  T817] The buggy address is located 112 bytes inside =
of
>> [   60.095541][  T817]  freed 256-byte region [ffff888170c8ac00, =
ffff888170c8ad00)
>> Best,
>> Shuangpeng
>=20


