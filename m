Return-Path: <linux-rdma+bounces-2802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA258D8ABB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 22:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408541F26ACC
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BD13B2B0;
	Mon,  3 Jun 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkWOetA0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECB1386C0;
	Mon,  3 Jun 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445440; cv=none; b=pGKUIvvIWzcWLae5XI0XAd9N7tiXsC8DpUCJY/nlSWYsz2ylOPdv+JAY/ojLe1g4z0Uf8Bk7Fg17QpQUgdq0JQarMrO/ttZWJQ9jqOEBw/5k9k1Ht3g6Cvq5O1pfaVsrkcU6UuJyvrGvpLJT6z4R50icGDzRkiY1qwxqkL2RP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445440; c=relaxed/simple;
	bh=x1O7edjDGbj6bbXUMLVTfHxEluKeFrflgY2spv1hY9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMBOmmyu9ByPjXQxyyGugN5db+pCWcbNG6R/HnRlYb7E0F4TxICHKdYl+RlC9h5SBBFLCDrfoZ14lsCvkN8U+O/fEyEDsV/JNO8N0lR/Ttj5ODN0yh+Bj4fldo1Ti2ZUZUcMxNonC8hsXVrRHuAnaR4wBMWvcf9In2wK8rqGtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkWOetA0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70255d5ddb8so1694094b3a.0;
        Mon, 03 Jun 2024 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717445438; x=1718050238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tB3oMH0/1iwURt1RuFxMD8K0WTqVNPre1pls3mzOWF8=;
        b=bkWOetA0//GZ+cJe7K4DXSTHyZEzU+RNehPVSDWjP+vqz0zw8oLN2IKA/q22BPwRBU
         ikrf2v6AL50e3pqiyEejwsm41ybkKYfE6G6bJUfMJYW2GNng2O+Zj/Rc6RW19hk3LTn0
         SankqLcKoyG1xsRTW4v+KGI0rIwCIm/tIqNC2E12PtYepShg5jCdHwwjzH37zYdC/U1+
         EelcnTe2W5aIA90RFyoiify4TcgHyf4iIijt8mxKdQ0ReDabs0Y0UOXsws9ajxbg9CbB
         dXbyOtmS/1IF2sHCAqCPZEYuh59Wa7WlN48qCbL7AhxSp57VhBvt1U4D7b5fVO8UsOt/
         2q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445438; x=1718050238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tB3oMH0/1iwURt1RuFxMD8K0WTqVNPre1pls3mzOWF8=;
        b=fQqw3Zt0Mv5e4UMDZvDgg3jbjzGmrlzez5nBP2YJyKk9f7DGpq7xUDQj7JxhVN2tBN
         dWr5ua6ZJ/57/+ysDOa7BGk1bpzGCtYTCOhnBwRyIG4hktjWlPEEg2Lkm7GPqSWI79jO
         AXzpfgKi3k7jBHtH6OSdYu5fje3t1gfD/rRG2kr1mDlwy7s0GwU8/wLNFgIqs8nmtmbL
         ANkSVe235ff3p0vGaoD+g4lXbcWVDiP7xSOZxccuGj7RdsdEp2l5SUtgxQ8GgHanJ6Lc
         8GqeKEnOhae1ifbIdRkUrtenbV7LfIWFSC7QAn3sy55rq7hwKyZWhqhCp2He9jj2TfpP
         ME/w==
X-Forwarded-Encrypted: i=1; AJvYcCUw4VBUJELWvwP5n3WBSsJdSyhb+NjnVs7vDavzoh2zG56+grFZLck2Agj1r0DjOQdi4nNqmtv16huQj5zcb3Uqvx5qbiWVt7jGPp4+3cajAhLSuDiIAJvJtQlXd0GWVA/wLnh1GSVrEQ==
X-Gm-Message-State: AOJu0YzCJwmWJ64uS5qa6eqcgnxVbbffYpnCkFv8oFJwxkKwsuEdp6vc
	vvBKj332H1GHZs5pJabKOkEkyEerR3d6YFKu5L06OqoIQtggZtTA
X-Google-Smtp-Source: AGHT+IEVQGnMSRE7zH6xgkRYedjsC9HbkRrCyp965UviTaBHJIvABANMTDro4pi/XchAtovJwS4SsQ==
X-Received: by 2002:a05:6a20:12c3:b0:1af:9ee6:25c4 with SMTP id adf61e73a8af0-1b26f2cc341mr10250089637.42.1717445438285;
        Mon, 03 Jun 2024 13:10:38 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423c69d5sm5908157b3a.27.2024.06.03.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:10:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 3 Jun 2024 10:10:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <Zl4jPImmEeRuYQjz@slm.duckdns.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531034851.GF3884@unreal>

Hello, again, Leon.

Re-reading the warning, I'm not sure this is a bug on workqueue side.

On Fri, May 31, 2024 at 06:48:51AM +0300, Leon Romanovsky wrote:
>  [ 1233.554381] ==================================================================
>  [ 1233.555215] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
>  [ 1233.555983] Read of size 8 at addr ffff88811f1d8928 by task test-ovs-bond-m/10149
>  [ 1233.556774] 
>  [ 1233.557020] CPU: 0 PID: 10149 Comm: test-ovs-bond-m Not tainted 6.10.0-rc1_external_1613e604df0c #1
>  [ 1233.557951] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  [ 1233.559044] Call Trace:
>  [ 1233.559367]  <TASK>
>  [ 1233.559653]  dump_stack_lvl+0x7e/0xc0
>  [ 1233.560078]  print_report+0xc1/0x600
>  [ 1233.561975]  kasan_report+0xb9/0xf0
>  [ 1233.562872]  lockdep_register_key+0x707/0x810
>  [ 1233.564799]  alloc_workqueue+0x466/0x1800
>  [ 1233.567627]  mlx5_pagealloc_init+0x7d/0x180 [mlx5_core]
>  [ 1233.568322]  mlx5_mdev_init+0x482/0xad0 [mlx5_core]
>  [ 1233.569387]  probe_one+0x11d/0xc80 [mlx5_core]

So, this is saying that alloc_workqueue() allocated a name during lockdep
initialization. This is before pwq init or anything else complicated
happening. It just allocated the workqueue struct and called into
lockep_register_key(&wq->key).

>  [ 1233.599979] Allocated by task 9589:
>  [ 1233.600382]  kasan_save_stack+0x20/0x40
>  [ 1233.600828]  kasan_save_track+0x10/0x30
>  [ 1233.601265]  __kasan_kmalloc+0x77/0x90
>  [ 1233.601696]  kernfs_iop_get_link+0x61/0x5a0
>  [ 1233.602181]  vfs_readlink+0x1ab/0x320
>  [ 1233.602605]  do_readlinkat+0x1cb/0x290
>  [ 1233.602610]  __x64_sys_readlinkat+0x92/0xf0
>  [ 1233.602612]  do_syscall_64+0x6d/0x140
>  [ 1233.605196]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1233.605731] 
>  [ 1233.605986] Freed by task 9589:
>  [ 1233.606373]  kasan_save_stack+0x20/0x40
>  [ 1233.606801]  kasan_save_track+0x10/0x30
>  [ 1233.607232]  kasan_save_free_info+0x37/0x50
>  [ 1233.607695]  poison_slab_object+0x10c/0x190
>  [ 1233.608161]  __kasan_slab_free+0x11/0x30
>  [ 1233.608604]  kfree+0x11b/0x340
>  [ 1233.608970]  vfs_readlink+0x120/0x320
>  [ 1233.609413]  do_readlinkat+0x1cb/0x290
>  [ 1233.609849]  __x64_sys_readlinkat+0x92/0xf0
>  [ 1233.610308]  do_syscall_64+0x6d/0x140
>  [ 1233.610741]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

And KASAN is reporting use-after-free on a completely unrelated VFS object.
I can't tell for sure from the logs alone but lockdep_register_key()
iterates entries in the hashtable trying to find whether the key is a
duplicate and it could be that that walk is triggering the use-after-free
warning. If so, it doesn't really have much to do with workqueue. The
corruption happened elsewhere and workqueue just happens to traverse the
hashtable afterwards.

Thanks.

-- 
tejun

