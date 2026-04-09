Return-Path: <linux-rdma+bounces-19161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ8rNL6b12kUQQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:29:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB03CA6D3
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7BB30414BA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8B3C5525;
	Thu,  9 Apr 2026 12:28:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4A3C454E;
	Thu,  9 Apr 2026 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737690; cv=none; b=CvKoF0u/O3Ob9WImNJpuPQwfA9oxnK5eSp4phkiPPY9zO2eYJNqewocwCu0qWSJsHeDw2wIwxSfGHL4dBS1UZ4YgZqi5CVJoeiapdR/gwgwzWRH11Gm3kEWuFKLHtB1a5rVL5Fw7MHggx73x+b2bcGNgPTEEkQR6UiJxFfb5raQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737690; c=relaxed/simple;
	bh=EjSozxrj+12LZ6FmGgkaCxCJVy6nYxsUeszd8Ocgt7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtigCPIjxMVtH9+os1GPaAC0ASbXGZHrupboCHrTHK5ORQLv7n+3H7Gh+YWa2AQ+dWsHkmIqPIou46jaSClw1zZk4uxJFa1FTG7Cg94LCJhZpu4DYBl6lCtN3LXB+4x2wV9SX0ImE2EogN5WiR9OwOJDmCy9lW7VKGK4NguPq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4frzcq3mgXz1HC3C;
	Thu,  9 Apr 2026 20:23:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6ED1840569;
	Thu,  9 Apr 2026 20:28:00 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnH+1Bm9dphfUEAg--.11564S2;
	Thu, 09 Apr 2026 13:27:59 +0100 (CET)
Message-ID: <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Leon Romanovsky <leon@kernel.org>, KP Singh <kpsingh@kernel.org>, Matt
 Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Jason Gunthorpe
 <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Chiara Meiohas
 <cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 paul@paul-moore.com,  linux-security-module@vger.kernel.org
Date: Thu, 09 Apr 2026 14:27:43 +0200
In-Reply-To: <20260409121230.GA720371@unreal>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
	 <20260409121230.GA720371@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnH+1Bm9dphfUEAg--.11564S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xAF17ZFy8Ary5Wr4xCrg_yoW8XF13pF
	Z5K3WftFWkJF4agF43Xr47uayYgan5JrW8JFnxt34Ut3sYyrn7Xw17Kr909FZrWFyfWw1F
	yw42gFyDWF1kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGnXEi8JxgAAsY
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19161-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 73FB03CA6D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> > From Chiara:
> >=20
> > This patch set introduces a new BPF LSM hook to validate firmware comma=
nds
> > triggered by userspace before they are submitted to the device. The hoo=
k
> > runs after the command buffer is constructed, right before it is sent
> > to firmware.
>=20
> <...>
>=20
> > ---
> > Chiara Meiohas (4):
> >       bpf: add firmware command validation hook
> >       selftests/bpf: add test cases for fw_validate_cmd hook
> >       RDMA/mlx5: Externally validate FW commands supplied in DEVX inter=
face
> >       fwctl/mlx5: Externally validate FW commands supplied in fwctl
>=20
> Hi,
>=20
> Can we get Ack from BPF/LSM side?

+ Paul, linux-security-module ML

Hi

probably you also want to get an Ack from the LSM maintainer (added in
CC with the list). Most likely, he will also ask you to create the
security_*() functions counterparts of the BPF hooks.

Roberto

> Thanks
>=20
> >=20
> >  drivers/fwctl/mlx5/main.c                        | 12 +++++-
> >  drivers/infiniband/hw/mlx5/devx.c                | 49 ++++++++++++++++=
++------
> >  include/linux/bpf_lsm.h                          | 41 ++++++++++++++++=
++++
> >  kernel/bpf/bpf_lsm.c                             | 11 ++++++
> >  tools/testing/selftests/bpf/progs/verifier_lsm.c | 23 +++++++++++
> >  5 files changed, 122 insertions(+), 14 deletions(-)
> > ---
> > base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> > change-id: 20260309-fw-lsm-hook-7c094f909ffc
> >=20
> > Best regards,
> > -- =20
> > Leon Romanovsky <leonro@nvidia.com>
> >=20


