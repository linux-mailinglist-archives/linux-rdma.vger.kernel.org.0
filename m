Return-Path: <linux-rdma+bounces-21410-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH5hGlC8F2qRPAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21410-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:53:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C36225EC4D7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8762C307D8C6
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 03:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06BF31327D;
	Thu, 28 May 2026 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXHWpt97"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F602F7F03
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779940383; cv=none; b=UqTif5Ck1v1UlEAH8MdeoH6/dBpO36ebCoHHS6yjtyBkRVYDMGdzBChs03sfZX2VWJg11OnPofPGkeStxwo1JQjiXaKuOoRzap1km0S+awFRSRMoSfUTREB1O4anw43R8Hh7npeiyvWn/IlvvfCuWS8BLOOwS0zlfGBsDIJY+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779940383; c=relaxed/simple;
	bh=DQnvRbLLDRnhIZeLmXh7LWHMsIlHKRRVHVxc+4Rootw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=V57W+bdMkQYh69NJxwa3yEPLnq4A6WT6hpCJ8drvDzlxWRZcvHUp5IjCu/TFn9175OyhmftgjHHWRYSiCL04/2oPviXY5YNNIXvVShbvZom/Ek7Sf127YPTy9g0W1GPnnw+mv2NTtNhTgZmn4rDiryrOkATHnhzMCBKdKtXhZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXHWpt97; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5eb0fabaso140666051cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 20:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779940380; x=1780545180; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dMrYjvINrkHP2I7aJF9Y7W20M5jqPVJtuCbsMxY9Mo=;
        b=VXHWpt97MiRkk4nOGl8At+ayXjNXgNBKpzoAzlJEgedS7rI/qTbHty1iN3eE8fU9wC
         huijaeAFnPSnsA3GyeCubRye0swlol+OxeTKg0hb/4zUp0joKnp/mhq+XWtgIkNEPWZg
         997Om5Iv8kfYsymcoJLGybX/W6ef5XHHmyWa5bKN0iP8EaEsBHb1sUbiH0DmxcgelfSY
         MkUTJLFzBejAf219U7DuB7o0/uT9hNe1RfZKriPCGmtrTc/sDwOU3ZlJF75z2W2ar2kI
         czgVDxdIxhzXMBSZkZghqcdilDRs8Z27TNeUAlJ4LWaQTjNPPVAMeg+NWBH0eXCkE86V
         tRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779940380; x=1780545180;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dMrYjvINrkHP2I7aJF9Y7W20M5jqPVJtuCbsMxY9Mo=;
        b=lgOgedAaYwBp7xQpjmXFpQ1XXDhQ3uPKU+fjN9w/d+pLhxWYQAWDianRAvmKLT8KcE
         ih9WazN7Asz15HJCNfBcgziBX6igpD15arvXPBJcbH0zo9if4XDCqePVVxGLsLORNDik
         NShvxSaKwyGrBivZHW6UI5S3G3IN+QjYUuyrdhAeqnI9pv0Uh3V1befXQCku9zJgr7Ph
         wFK5xBXDJMU+bofXx6vGX+9XNGFbXOrbYr1ESRueDaaz22I+qKRgYH+qkeWiZXZY2IAk
         J+acULqIMn/WuqQFKgA+mDFPHqt7Q/B0WntTBXWWUKn60hYwGXvz2R0nntg2RpzGofwL
         ilcA==
X-Gm-Message-State: AOJu0YwZj5JZVBhRHVwltvajFzUmuCxFmgzo+rOmUeRJNSVQ5N6a6gOf
	IZooP5sETnEf8WdDA/XRhDYMiF4my0R+2nXBoB1DW2SLHuu2Bh1dFg26jIUWhLAa
X-Gm-Gg: Acq92OFVqdlhf62At0uuwqqpfb44A6oWORaFQQ3lZNOwBAc8Yj/jD93hpGOT7096MVy
	C/T5BOF7NIr76CeKappysAap5GGpd7groB0V+Yl8AdpNgtHZWmS7LeQURFq1s2vZtyiGQtqpF4B
	GetgoVYWMSKHlpxpFZ+d9TnavRucwSu0juV44qUcILiYBuzVIZ5TZRmPDB4WBTq75cnQV9GDtMa
	mRXM7sIbEkcXTid+WhLMv5p1xhindasTQ8hTWRxpc3XrA6Rxl+JE/xrSv1Y3l/q/kK+ymXPWd8Z
	OfksYpMlunouRDlNDKDGClBaMKglHC1DpfRoDOVJOtd+nUl7bTO6NzNTcIWDNr7POISpK6Y2Xbz
	L3V7sm6V3zexswkKSKvQSo1jVUqR7QC9xseIaM/vtUbSkdbuZhqcYLDysE8iSGiDQ9u9KYcA4Ga
	FhTA/rtNKuq48GGXuglzrvSbGTj8W7gCMQ8trCyp/Nf22yA0HkfnVz/cEMkGbxeZ2BLh1+fiAuB
	G8=
X-Received: by 2002:a05:622a:134f:b0:50d:6b06:a453 with SMTP id d75a77b69052e-516d445ee68mr358347531cf.18.1779940379892;
        Wed, 27 May 2026 20:52:59 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:e825:366f:655c:9bfd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b081c7sm62479651cf.28.2026.05.27.20.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2026 20:52:59 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free in siw_cm_work_handler
Message-Id: <FFC7BFD6-EDB5-49AE-ACB5-A2F940D8F687@gmail.com>
Date: Wed, 27 May 2026 23:52:48 -0400
Cc: linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: bernard.metzler@linux.dev,
 jgg@ziepe.ca,
 leon@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21410-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C36225EC4D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free in siw_cm_work_handler

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer, detailed document, and .config files are here:
https://gist.github.com/shuangpengbai/f8a60ffa1b95c54672433bd9ee82e8ce

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>



[   60.059964][  T817] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   60.060980][  T817] BUG: KASAN: slab-use-after-free in =
siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
[   60.062008][  T817] Write of size 8 at addr ffff888170c8ac70 by task =
kworker/u8:1/817
[   60.063033][  T817]
[   60.063347][  T817] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   60.063350][  T817] Workqueue: siw_cm_wq siw_cm_work_handler
[   60.063356][  T817] Call Trace:
[   60.063359][  T817]  <TASK>
[   60.063361][  T817]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[   60.063369][  T817]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[   60.063385][  T817]  kasan_report (mm/kasan/report.c:595)
[   60.063399][  T817]  siw_cm_work_handler =
(drivers/infiniband/sw/siw/siw_cm.c:1053 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
[   60.063472][  T817]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[   60.063477][  T817]  worker_thread (kernel/workqueue.c:3478)
[   60.063484][  T817]  kthread (kernel/kthread.c:436)
[   60.063495][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
[   60.063511][  T817]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[   60.063515][  T817]  </TASK>
[   60.063516][  T817]
[   60.087529][  T817] Freed by task 817 on cpu 1 at 60.059899s:
[   60.088264][  T817]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[   60.088821][  T817]  kasan_save_free_info (mm/kasan/generic.c:584)
[   60.089385][  T817]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[   60.089940][  T817]  kfree (./include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   60.090383][  T817]  siw_cm_work_handler =
(drivers/infiniband/sw/siw/siw_cm.c:141 =
drivers/infiniband/sw/siw/siw_cm.c:1051 =
drivers/infiniband/sw/siw/siw_cm.c:1075)
[   60.090979][  T817]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[   60.091616][  T817]  worker_thread (kernel/workqueue.c:3478)
[   60.092191][  T817]  kthread (kernel/kthread.c:436)
[   60.092637][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
[   60.093226][  T817]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[   60.093782][  T817]
[   60.094033][  T817] The buggy address belongs to the object at =
ffff888170c8ac00
[   60.094033][  T817]  which belongs to the cache kmalloc-256 of size =
256
[   60.095541][  T817] The buggy address is located 112 bytes inside of
[   60.095541][  T817]  freed 256-byte region [ffff888170c8ac00, =
ffff888170c8ad00)




Best,
Shuangpeng


