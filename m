Return-Path: <linux-rdma+bounces-13607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BBBB978CE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C916D4C1D98
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AA30C34F;
	Tue, 23 Sep 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="G3mlaZ9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3D27F732;
	Tue, 23 Sep 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661794; cv=none; b=SOtwFolOd+GkLIzd2OnhCrN7ar643xX26O6+PCuviQ9ZHuqeCQxxvKdNEaEQBwWY6TCcI2A27ySAUH5xY7eAAj8QKK5tgStJgA3en8oapxqeiQBFb6IwWn0HsvLZB9UOiqHS6KDY7ODOJEa0zbo6kmbhCi/AiPljTLES3m994VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661794; c=relaxed/simple;
	bh=5fol8pIH1VwzVB/nc+utnngJL5cNP44auAOCngKKyoM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=COEtKhYyKWnFwldcEQC6iWas6ZtJVIDtRGXKENKGHGge4YeSjWYjdcQgI9rhBtuPhw1flD9M9UY1sL7sR80K5I/P+sFfdZfzysxyO6S6IE+kQVSCHK6X/RsOcDvz11OOhASRE8nkkcWow66C1jNFIA4CzykQgq3w1SHHIRVj1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=G3mlaZ9a; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:To:Date:Message-ID:CC;
	bh=5fol8pIH1VwzVB/nc+utnngJL5cNP44auAOCngKKyoM=; b=G3mlaZ9aaGOBqyKHjbvkgJOpbr
	kKIRLKNn6xpbzOfr1ede/IGsCtvAMrDHDDruT3tGKT4uNKhOqU2KucVHnYHh7wmyNqx42uKgvYIKc
	da26exQvpuW1krgpiRf5WUtaMXHxIspcTyJxXvJfHYDnHih522N53QBy7mPF6S1c0d+q4nHNKncAN
	onCTHgBIlbnzWp/IC55vuoUxCi5e+ENiirQ9ffv7SQ3DU2rYylWieLTnt1Rf88xypJeSEnH13vs78
	jbfyIUuQt1u3OwL9sg9+OjCOBJacNStggAyTQoo8TGn36x9MXh2044JAruW6BmmocSX4JlbdLDYdt
	rxysDtoqRoMaJ1wcLIKPuII2EOZNAxRs4azUyrfeakvsKaMz2fKfXowTwWCjV7j8OcQayBD4JDR2K
	uCpO/Upd7Pa2Sl5s62Qyp0TE/J+rPjfQJ96Oe4pRX7lg0YRt4RHicQshImiOAPJuuF0Ccd1SLpw7J
	E3hSYboeNS3baz0rSq+TMSKP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v1AGj-005d9m-25;
	Tue, 23 Sep 2025 21:09:49 +0000
Message-ID: <656eacb1-a39f-4b59-99db-5522d102468a@samba.org>
Date: Tue, 23 Sep 2025 23:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
From: Stefan Metzmacher <metze@samba.org>
Subject: Does ib_dereg_mr require an additional IB_WR_LOCAL_INV?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to understand (and hopefully simplify) the code in fs/smb/client/smbdirect.c,
related to 'struct ib_mr' cleanup on disconnect.

Assume we have the following sequence of calls:

...
ib_alloc_mr()
ib_dma_map_sg()
ib_map_mr_sg()
ib_post_send(IB_WR_REG_MR)

On cleanup we currently us something like this:

ib_drain_qp()
init_completion()
ib_post_send(IB_WR_LOCAL_INV)
wait_for_completion()...
ib_dereg_mr()
ib_drain_qp() // again
rdma_destroy_qp();
ib_destroy_cq(revc_cq)
ib_destroy_cq(send_cq)
ib_dealloc_pd()
rdma_destroy_id()

Now I'm wondering if the following is really required:
init_completion()
ib_post_send(IB_WR_LOCAL_INV)
wait_for_completion()...

It would make things much easier if not...

Thanks for any possible hint :-)
metze

