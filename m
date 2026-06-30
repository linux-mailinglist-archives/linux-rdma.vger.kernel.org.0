Return-Path: <linux-rdma+bounces-22609-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2VUMDZYWRGpEoQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22609-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 21:18:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8856E7812
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 21:18:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=hZyDIg4Z;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22609-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22609-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F37193058B05
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89513C2BA3;
	Tue, 30 Jun 2026 19:18:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF633B71A8
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 19:18:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847122; cv=none; b=aMOL1Qo9oJ16BpO7MZciRaHaHXMSaAcNGlMVn00jgx84PvVLevW3LtXbjrudiguLLoFArz2NKE4bBynOnhnUsDfBKl6GoV64nUE6vRa8sKUnHSrDHsT5RygQxeG3Bpb6RLQ42Q5ReaBlJvJxaWs424waKYzZVchOViLvjQpJ/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847122; c=relaxed/simple;
	bh=/cGCMrwv5IeSO8uLy3P9jHnCB5F3ru+595837KJx+vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZvSUnTmli+B5mqhcE4xDTpnZxWw7hQU2ifjSVVreyM1NBdkgDjl4GNrC07ZYlVdJMs/jeGpcBOIrCXYPTwXObTTWLxHFUJo0WH2grIJF8x1cpTDwViV9LL945Cd5BYWmaXWbQ9XUyK6BuySwoCpRi8fMzPW2ZjAjgssCe+n8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hZyDIg4Z; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516d0db9372so39343461cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782847118; x=1783451918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0FHnTnQXrfPmQbScDCuws0MkpOwZPKKuZko8hQ7ne4=;
        b=hZyDIg4ZTrdz4NyH7Qd27XrK/1+ciwJYruU4/cqPFoPBnGYbkpQOD/O+NSjFAA23/U
         5LLmg5eevUBvk51ddwXgiIe1Ay0Y/lGUcc6g7fzbEZpG05fVpaf2S0ycnmSE2opboncf
         gc3bmacE/sGDkdpI8JQHGUrhgpD9btlQrC3KvBLSBa1W38N3Sqmn4ok1gLvdcZcBnt2e
         IYnPitK+DcoN1vTTUzQa+wfyL4Peybu1Z6c5M5zsr0syUtZPWYEYnkpR1F8Gjd/14KCQ
         iFQb9aVUl8U1ke36JeLnf+pk3JnUzkIP3msqoSm4FHUnOzurm1l9exK8dLfYUHBh4U27
         v54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782847118; x=1783451918;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0FHnTnQXrfPmQbScDCuws0MkpOwZPKKuZko8hQ7ne4=;
        b=UE+bqkQ/zJFM9E6OscHe2IZbiD9sedpoo4nFqQFg+94wmbIymju56SXrFq/SDHpz4+
         4JgsP+aCvVQJLjg/1IQmhce61DYEjOJuD1YNswqERi2IvgdT2uiVnyKNWFwKH1+vCZXI
         07QzjknvBN5vTklyCZ3DxspRnMUL7M/IaRBSB8SoXfezKc5ILeMQ4koCsoucoiBLYvjk
         kOIu3PAD9p7iW2ZtZL3yibvnBi+6HhGOu7QlprSyqviBQKUwxDvSSy+WG6Ygi41h8x8w
         e5wGxehF2Bw9+l3LTJ/QgLPECK/EVCde9dblceoAHBQMNyPtFmRQA0U7RBVr83dJ1zPz
         x/cA==
X-Forwarded-Encrypted: i=1; AFNElJ8d9/ALeSsRp5cZKbAywu06JwUlTR7r2412wH+HZdfWJYohUXEBuWm95zdno3teXiRd454bI3XNN0SL@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpyqrJCh84XQWqeYj49mm4gMk+614ZeODKgd93hqvl4SjGU99
	MGJ4Pz+hNq/hcxdYdGAfTvU3xAxXVblRJXo4KpGAoudMfLMdT5aLiSsalekl+OFo5zk=
X-Gm-Gg: AfdE7cnSJpFUw9zDI/8l31dY/Uli0lkttNPr7DkjsrhBh7N0aLwCQuRfme+Zz7a4ryg
	WYpg5w3d179HRJ7QOz0kbFVwguOOdD2vpprlT5mhpuDDk2TBS4mHf6xOd2I2npChp/5uamNXY5A
	LdORnMXcgWEWiYXxPIh3mM2Rm6HptGyr4zz6X6HiZ7SnT10WKUZdLpX4LKy9Ll6m2A5OJRSqXmZ
	BNxnXnpngmZdXbbrhd61ZKdFEXsQcBHU4oTwH/gFcoG6XyAXh41OtpcoFY9sNE5diE8WNL3qUIY
	ors0wF6N6sMuBkdz/6VpXd1zBI2IWK8mK+SH1NQo6PqrYQAiOIOsq1QMM6xbktkWOSZfcKXa1vQ
	Qq3tNtHYgjv4CzQfcoAqUZkfK7kZDabI/ZTAgVk/3wzsSapa5jqn8xKioXBhdIohZIkeRfoBaCP
	GoClR4y5yd9iuCWPRhEiMJ3fVNlY1RvD/jQFkAO32QbiL43ToYPc4rlDMlotKYSZaZbhIBGE5S1
	sSh/g==
X-Received: by 2002:ac8:7d52:0:b0:517:85e1:388f with SMTP id d75a77b69052e-51c107f4537mr59690751cf.30.1782847117841;
        Tue, 30 Jun 2026 12:18:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a27e79f5sm30572516d6.1.2026.06.30.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:18:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wedye-00000002N8D-2DUv;
	Tue, 30 Jun 2026 16:18:36 -0300
Date: Tue, 30 Jun 2026 16:18:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 0/5] RDMA/irdma: Adopt robust udata
Message-ID: <20260630191836.GM7525@ziepe.ca>
References: <20260629232532.2057423-1-jmoroni@google.com>
 <CAHYDg1T099scmOKWXXV25OvOBNBFMA+Fm3ev3Cs+51JOCQA01Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1T099scmOKWXXV25OvOBNBFMA+Fm3ev3Cs+51JOCQA01Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22609-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC8856E7812

On Tue, Jun 30, 2026 at 01:23:04PM -0400, Jacob Moroni wrote:
> Hi Jason,
> 
> I need to respin this yet again to fix a few more sashiko findings (sorry), but
> I was curious:
> 
> Looking at bnxt_re and irdma, in many cases where we use
> ib_respond_empty_udata, there is also a check for
> ib_is_udata_in_empty.
> 
> Should I make a combined helper? Something like "ib_check_no_udata_io"?

I imagined that the functions should all have a common pattern,
validate the input at the top and generate the response on the success
path.

> Also, for bnxt_re, I think there are places where the ib_respond_empty_udata
> call at the end of the method could be problematic, particularly for "destroy"
> ops since the driver doesn't check the return value. V1 of this series did the
> same for irdma and sashiko freaked out.

It should generally be called at the end of the method, and everything
should be careful to undo their stuff if it fails. Much of that is
bundled into the uobject abort mechanism so it happens transparently
in many cases.

> The issue is that ib_respond_empty_udata can return a failure but the driver
> doesn't check for it.

It does check, I guess this is problematic that the object is already
destroyed and cannot be undestroyed at this point, yet could be
destroyed again.

> Does this seem legitimate? Anyway, a unified helper that is called right
> at the beginning would eliminate the issue if so.

Yes, that does seem like a good reason to make that kind of change.

Jason

