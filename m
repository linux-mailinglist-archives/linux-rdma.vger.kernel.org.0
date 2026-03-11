Return-Path: <linux-rdma+bounces-17944-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNGfEy0esWmOqwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17944-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:47:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA97225E2AD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F6E329F83D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5073B2FE7;
	Wed, 11 Mar 2026 07:36:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E43B27F6;
	Wed, 11 Mar 2026 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214602; cv=none; b=pXH8V0rWIP10ku44t369FtLcYXgHpqvfdmBu0qAfT5LPJQYSLLt/yQN6MwZegjyfAejKUdsbZWVy/aUxiigPPOWN4m83LdrtU/WhLbDkfJvpOQQuQ4EdNttTrA3uz0Fa6bfhBUoaN2ivlyADgqTI8OsTZ4tClDdTiOySlBlN8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214602; c=relaxed/simple;
	bh=zCL3VacVB1N095/jx1Q+CI0H/+tK3fJ/YGoEVk3Gbqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=DmX4XQwIysRvFFUpMA5gNw/X8B60Oteh02PxAyclX2TD9fifxr+3l92T6HW+wkiTj2gqAlCKgw02AZzTfYZ8ntI77oqq3FHToZlmJxBqDD6puNrvhoqnaDugs1tvE9iS8qzX7KBSqp4ZR6uWLzHZ06x5pNrRzLLIojMPAW+3ZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 1f15775b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 08:29:51 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 08:29:51 +0100
Message-Id: <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "Shinichiro Kawasaki"
 <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <aZ_-cH8euZLySxdD@shinmob>
 <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
In-Reply-To: <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
X-Rspamd-Queue-Id: AA97225E2AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17944-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[arkamax.eu];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.965];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlombard@arkamax.eu,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arkamax.eu:mid,wdc.com:email]
X-Rspamd-Action: no action

On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
> On Thu, Feb 26, 2026 at 4:09=E2=80=AFPM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
>>
>
> I also reproduced this kmemleak issue with the blktests nvme/rdma
> test. Here is the log:
>
> unreferenced object 0xffff8882e7545a40 (size 32):
>   comm "kworker/0:0H", pid 36658, jiffies 4303559899
>   hex dump (first 32 bytes):
>     02 81 aa 09 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>     00 40 a0 6a 82 88 ff ff 00 10 00 00 00 00 00 00  .@.j............
>   backtrace (crc e5de3e0c):
>     __kmalloc_noprof+0x6f1/0xa10
>     sgl_alloc_order+0x9e/0x370
>     nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
>     nvmet_rdma_map_sgl_keyed+0x25a/0x940 [nvmet_rdma]
>     nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
>     __ib_process_cq+0x139/0x4b0 [ib_core]
>     ib_cq_poll_work+0x4d/0x160 [ib_core]
>     process_one_work+0x8b1/0x15e0
>     worker_thread+0x5e9/0xfc0
>     kthread+0x36b/0x470
>     ret_from_fork+0x5bf/0x910
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xffff8882e7545280 (size 32):
>   comm "kworker/0:0H", pid 36658, jiffies 4303559900
>   hex dump (first 32 bytes):
>     02 2b 82 0b 00 ea ff ff 00 00 00 00 00 10 00 00  .+..............
>     00 c0 8a e0 82 88 ff ff 00 10 00 00 00 00 00 00  ................
>   backtrace (crc 42d20147):
>     __kmalloc_noprof+0x6f1/0xa10
>     sgl_alloc_order+0x9e/0x370
>     nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
>     nvmet_rdma_map_sgl_keyed+0x25a/0x940 [nvmet_rdma]
>     nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
>     __ib_process_cq+0x139/0x4b0 [ib_core]
>     ib_cq_poll_work+0x4d/0x160 [ib_core]
>     process_one_work+0x8b1/0x15e0
>     worker_thread+0x5e9/0xfc0
>     kthread+0x36b/0x470
>     ret_from_fork+0x5bf/0x910
>     ret_from_fork_asm+0x1a/0x30

Maybe the problem is in the nvmet_rdma_map_sgl_keyed() function

static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
                struct nvme_keyed_sgl_desc *sgl, bool invalidate)
{
        u64 addr =3D le64_to_cpu(sgl->addr);
        u32 key =3D get_unaligned_le32(sgl->key);
        struct ib_sig_attrs sig_attrs;
        int ret;

        rsp->req.transfer_len =3D get_unaligned_le24(sgl->length);

        /* no data command? */
        if (!rsp->req.transfer_len)
                return 0;

        if (rsp->req.metadata_len)
                nvmet_rdma_set_sig_attrs(&rsp->req, &sig_attrs);

        ret =3D nvmet_req_alloc_sgls(&rsp->req);
        if (unlikely(ret < 0))
                goto error_out;

        ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
        if (unlikely(ret < 0))
                goto error_out;
        rsp->n_rdma +=3D ret;

        if (invalidate)
                rsp->invalidate_rkey =3D key;

        return 0;

error_out:
        rsp->req.transfer_len =3D 0;
        return NVME_SC_INTERNAL;
}

If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
nvmet_req_free_sgls() before returning an error?

Maurizio

