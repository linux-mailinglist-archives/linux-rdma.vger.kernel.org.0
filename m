Return-Path: <linux-rdma+bounces-20959-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF7oIyNcDGrMgAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20959-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:48:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB857EFD6
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 686BA3026029
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D24DC540;
	Tue, 19 May 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hT83QrKL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B84DC529
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194765; cv=none; b=TdN7ychXnfZ9sUWbtdujKpjHyd5HEmZi2VZK2yrXrTR7elEJ40lfzkaMPDh/pvSl0k6YPr3g5z7aZmWCCS6AgC/mSh5M2Xznt8H0BSt1zvlr1USpsnrsireBQB7n2eBN0e4MHqxlu+RspZhhDn3kDaXefDpjuOOqJmlIxy7ruyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194765; c=relaxed/simple;
	bh=t/f3Nez6J9IKnY/BPwvt1eQgDgtap/h3EXxVr+AaCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS6tJCJnCvC56a0GJ6vxYTe8LA6JJcHbC2EnHYOIdVTcOfNNUx8OwYitqdxZRs3PVLzwUvsyMWMfGl8GHTuTQf7k19AmWtEkPZnRfwiR6Wbw3gX5Ztpy9uoRsr+T/2CkoyYY4XcoFksi1aWCriF66MRNRrY77jPdaGWmxqpFYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hT83QrKL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9116861f004so850326985a.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779194761; x=1779799561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sa6XrBZM6Cw7L8P4/7hTeXZX3E1zSrMvWVjJ2o8swa8=;
        b=hT83QrKLbbnFSuyUnIjThLZb0m/b/2oQzn7Fn1aNBp2YNXu2xwIWVhG/rk43002qTo
         Thd85SoNJTClCwupHB0ln3etyU6NSr+1SoAAKRFeLInXKfikRCQV6h6CHLv33weryvZh
         dL2LqbG80ZXQexfEc27UmcBhhX+qMqxXah/Hi6ODqM6oXEZYBph6j/Nr/bzkoMxYv7HV
         Mrln4ZxxuDw9okBMVq3XSYIy90rRhoYeeNnsXe6I2+7utdBR9ImS8fli+qBWJVoWgku5
         d6laSSPEOCUtkpe6RrSzh+Ox6sNItBZyMPwEQxP+qkbuwAVUAh+jOL9h3H3xQmfsT/v7
         8V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194761; x=1779799561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa6XrBZM6Cw7L8P4/7hTeXZX3E1zSrMvWVjJ2o8swa8=;
        b=SufNVLoI2I/xlZDV3Ain/FmL8Oy2jsMwQQM226mz5lTmi+r9yGCrAzOmAoOKWU18Cn
         X8y0kHIy8j0uHHa19qA+8EBlgw5UeJIYyvYVmrYEJoGvkKipJrozAfk+uIu5V0WOdgED
         q2nUEKeT9k4teWgQCAxy9XfGd9HhVs7TjRshXJDKDOXMgrfqCIhbcOHdSmq/xaKR1jhI
         mQSCTix3y8Psna/tOGoxj3xIQOjdDaiDCxA26FqVwf9SqSb34Ubz5oDcLlxmX4v+zy95
         Wi/qbW/fmoBL1PMrTLjYMxrgbe0DIBdxtmkcOxVBG4wHchlteNkmxjCEgykoOlZifKgd
         kgxA==
X-Forwarded-Encrypted: i=1; AFNElJ+uYrUxYawFxTlDIVvMmdGRqD3BuJR6NNyi/4DwbGqytFO6oTSwEPuJeKkLyQW/4g1+ZG+jZNVko+wM@vger.kernel.org
X-Gm-Message-State: AOJu0YyX02W4sf4Oxre+PgC0fFH3KQP9neOrRUzQMICSwfeYGjBrCeqB
	3fh8B2twMfhodHQYmR/UARpHac/81UJ5nFYknH6IyVg64z2tvbJVxgUW0dCL4uD98n8/KjvXHsn
	f3MBL
X-Gm-Gg: Acq92OH8DwUqGW47d7KWnlNzMwfnY+uLqOSHaDOC0HWZseyIQqSqjCtdFswlOCn34I4
	gwbIeQ+jM3rlwaYQ5253bPMW4tSnKDeOymu6/eTZhEwnsO+4ah06Y9rpKPXkdwqbSme1qp7MOc8
	yiPJUmG4ruVj8KVDg9lZ8pqh5uUheC4y37W8Xxmi1SkB3KZSwnIPKr1CqpHw4/FtxbdtcrUGCZz
	U0/hOJF6GQyD70LZWYK2w1LgLvvi+kzqni8gztTj4Q8btEj4AdcSnghx20cly5wCozhGylQX2n+
	jyBmshfh8PM3rFN82EtJUHmHMj/xVTmxrMne9PKULZ9daO32evDUEJX2gju2OsLnJ2qsc9BEmhC
	xylCCHQj28elbaLwlq18XQDeaHzRBNBpftZ0dlJht/oc9JO5s34PpINu7K+f2xti79CFjqcx+wA
	ZxpRbE39/2iqOpenMxa7goiDP7wRSVk1D5VwnidUlwy1szpvneN6iwwizanwpa7tQO8hioG+UQ/
	xUexA==
X-Received: by 2002:a05:620a:94c:b0:912:3ba0:d2c5 with SMTP id af79cd13be357-9123ba0d504mr2193707285a.51.1779194761399;
        Tue, 19 May 2026 05:46:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3584esm1792979785a.34.2026.05.19.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:46:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPJpg-0000000EfWu-1AGR;
	Tue, 19 May 2026 09:46:00 -0300
Date: Tue, 19 May 2026 09:46:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
Message-ID: <20260519124600.GX7702@ziepe.ca>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
 <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20959-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7ECB857EFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 02:57:16PM +0530, Sriharsha Basavapatna wrote:
> On Mon, May 18, 2026 at 9:17 PM Sriharsha Basavapatna
> <sriharsha.basavapatna@broadcom.com> wrote:
> >
> > If the DPI is freed when the dbr object is freed, but if the
> > process has not unmapped the page yet, then the DPI slot could
> > get reallocated to another process while the original process
> > still has it mapped. To prevent this, save the DPI info in the
> > mmap entry during dbr allocation and free the DPI slot from
> > bnxt_re_mmap_free(), which enures that there are no references
> > to it.
> >
> > This change is needed to support doorbell allocation to QPs
> > in the next patch.
> >
> > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> > Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c |  4 ++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
> >  drivers/infiniband/hw/bnxt_re/uapi.c     | 12 ++++++++++--
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index 9fd85d81bcea..b8e46feafee7 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -4943,6 +4943,10 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
> >         bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
> >                                   rdma_entry);
> >
> > +       if (bnxt_entry->mmap_flag == BNXT_RE_MMAP_UC_DB && bnxt_entry->uctx)
> > +               bnxt_qplib_free_uc_dpi(&bnxt_entry->uctx->rdev->qplib_res,
> > +                                      &bnxt_entry->dpi);
> > +
> >         kfree(bnxt_entry);
> >  }
> There's a sashiko warning on this change:
> 
> "Also, does this introduce a use-after-free during device hot-unplug?
> During hot-unplug, the RDMA core tears down the ib_ucontext (which
> embeds bnxt_re_ucontext) synchronously. However, active VMAs outlive
> the ucontext because hot-unplug only zaps the PTEs without closing the
> VMAs. When the process later exits or manually unmaps the memory,
> bnxt_re_mmap_free() is triggered. Will dereferencing
> bnxt_entry->uctx->rdev->qplib_res result in a use-after-free since the
> uctx has already been freed?"

Hmm! That is a pretty reasonable assumption..

> ufile_destroy_ucontext(reason == RDMA_REMOVE_DRIVER_REMOVE) -->
> uverbs_user_mmap_disassociate() --> rdma_user_mmap_entry_put() -->
> rdma_user_mmap_entry_free() --> ucontext->device->ops.mmap_free()

Yes, that's right. The disassociate removes the references from all
the VMAs so it should always eventually call free.

However, it would be best if we didn't have this code in the free
callback at all, ideally the destruction of the object will happen in
the uobject destructor not the mmap free. However, I think we lack the
ability to do that right now.

Jason

