Return-Path: <linux-rdma+bounces-20391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAzWKhfTAWqXkgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:01:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC050E683
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC30302413A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3639FCDD;
	Mon, 11 May 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+DvyGKL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEB36AB61
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503830; cv=pass; b=INs+8nMNZuz5IhJYVdamSOj8vEriLpdAo4EEhr9XHeizWFS1b9ZxEvWj9b2SMUtJbIBkp0xmWWszP+SYIfpXkzxf8x0XbALKGIjMdasvGDc4E3Eo3wuyclWh1Bs3bTyCfZ5hCvF3q1M5OTMncpiiUKm02yWb7qadRbh5MZEIQa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503830; c=relaxed/simple;
	bh=hfG0lTXFFFerQgdAwR6QjapncjrKeuHWYgYBjLOxmlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxx3yPTFCF3xkZEJ5g0gxwyNEwHxlH6t/DsQ+sPHuYB5Tegnm6dXMnxHBcZELRLYRLlL6EVbCYnsTtCqSuVzu8QleKvs3aIsfxgepISCdOXcaB09IEAQU1/3NK/bd6o7k48i+icNpMGUPEZ+PSjdLXjC+YqlzcBv2IpxtDW8cxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+DvyGKL; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64eb84d1e37so3295865d50.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 05:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778503828; cv=none;
        d=google.com; s=arc-20240605;
        b=kAnL6HEptnbyMB+x3ACCwgmOhOK37cypamTlkDtxeDpHkIRKpSOB9BUtrPxWkIGpua
         LZd6m4V/Aq5QIDWMzzfoqo+pM/8MRREu/QQgN0kQLUzcQo5oPeNsY2xqXgejo0yAOO9n
         X50JMi2zueeqWzU6AZp0adWGZyXp5kSVadBs4/f0133vQOlXz0ctC2OD8mjn5l4xSjPn
         ac7t4HxYkp9I1qAu3XLrsJ4uAR6Mb2h5zDDHey9Kqs/AD1DqrxSFp6yw7O6gF7/+Nog7
         aDOj1OGrKLh2EIP+1FFGrugHidChCVCKjHuOqtF3tJaGhDQoojx7V8wVonq6YQ6Rqt0Q
         mMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hfG0lTXFFFerQgdAwR6QjapncjrKeuHWYgYBjLOxmlM=;
        fh=fRIgihCnzDTu8ktqK5y+nN6bFoB5tLBZbd8CjniY7ag=;
        b=UnfHxk7BfI3kEPLVjKyn4ZCzyeBxtdiHh6nyPQDaF94JLwuIvrZj99jFdr5wmZsmZq
         VHnIHzNYSY5zASMQEbCOD5LC+tNBoWhga0iCTGwsPFAvdzFMunKIUWf3xDXD7wSV/7kQ
         FnRkUe9NrrWXepWqLtXEWPfuAy2ZP6dTdQTJ7NqrV0ybM50hh28uFDw4IYramarnbqDC
         CcjEFlmxQgpvKPSjc4BrGC/pn+ezoLq3uRA772Q7rJ2Pjvfn+1We3bDlFFeZW/ufSVgl
         kb+KN9VBSo/D/PrBcHg0unO8wmEAWF6NaLmEyyOa6HAEcQXvsLjnudeA9DVQAj/Vb0+U
         MOow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503828; x=1779108628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfG0lTXFFFerQgdAwR6QjapncjrKeuHWYgYBjLOxmlM=;
        b=E+DvyGKL8oohOyCQFKgZGe9T9CN4whRstZbEl7sZokY1zLQYrxvwQzMwN06G46kaLM
         jfS+AEj5Zwm4NuLcZIv0EgBZfHUZQhzaPgbX0W1d1chtMEklAnch5+0tv/7q+7G8u1QJ
         n+03dquIG0nrUeLAM0YcIdz1h5nbIgkzPZeCc/IYTB/TfB/6YDt+EipH0kjrYvpxWhSV
         McCylLQIxkDi8UjPokIEMBoWkcz0iz9qgSzwJ/s0w+bcREUgNf+xlKGI5H9NPSgFziUx
         zwukzvcE9kFPvqwG8O/Mb5suuob/XbUrlhdnh0oDV3gaA8ZwgOPHh8io+q1ijw9kasgy
         CGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503828; x=1779108628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfG0lTXFFFerQgdAwR6QjapncjrKeuHWYgYBjLOxmlM=;
        b=Bx0I7rbUI0B1ie884M6vNGsISlJXRucl6eQMMFu66l5KC1R1682w4buC39dvYVvn0A
         CNj1qZTKaaHlTD7vkFacFXbuXfAMJn6YiVd2Uk5xLqf80Q972bXiH9bGkrcdFFPpvfgj
         ZCPsEpbjmDyst2mGGwPkeoH5lEH7/lpWNaRzASsjxbafG71PbXizEhdMeFZSbSNWo0j2
         9ab5o4DZooGi1HwXjNu6z9nzcuVRxkl3didFu1qOTpaNUpwdMxwypnhES+EFNrVX9zMY
         5AU2RdRjb2JIZLmm341YuVnm5LFCKu+zTFiJZYQ6yYXUF9YZyTVyfKTGjC2NhSq07ZGE
         GOGg==
X-Forwarded-Encrypted: i=1; AFNElJ/HP5aGt6razI87wfomYY5vZyVJNod75ETJLKKgR2t5kJ+uvmAl+bovm7X1x6P3nyvIhxzjRbMNg8s/@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdY4P181zw5MoIlAnXoSSXJQGcMoCTIta6flMFyN8KSYYjkGK
	4jykCDtaZFOJdH0FNXNaef9rNJ90JVqyrHCMYfqgqgUOr0sCSJ9HnWofOCZfUUWIVM+pdewNZct
	GTem1+dkD252cTOCNfgSIDRYTjytw6eU68CceWgQ=
X-Gm-Gg: Acq92OFgU5/VEZYFvPIPQXhAFnO2ShoDrN9RnTDFBOQTXMPb071OffG45d5nqDodk84
	5489QSF4Ag8x25lG/3QghUmGUJDUEjzSRGNQriNfTJNRoFE/f/1+yb9xGwW2iJqD8MqoqZErZNS
	wPE6NXxrGZ+t1iUUNvVg1jlYdxLUpKsmCkFZLXlMFRfqb+FQAYPBQdqGLzntSghnkeOI9DOKQao
	1WUzwCgTqwJbumH1RQts1/D/OwH6+j6ImTXhMF1plPQrppferf5itwHbSFmyCLYzE3TDskXHNqS
	aUFdv71H
X-Received: by 2002:a05:690e:1504:b0:652:5567:b3ec with SMTP id
 956f58d0204a3-65da84d5fcamr7917912d50.37.1778503827951; Mon, 11 May 2026
 05:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428105515.362051-1-lgs201920130244@gmail.com> <20260511113556.GH15586@unreal>
In-Reply-To: <20260511113556.GH15586@unreal>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 11 May 2026 20:50:16 +0800
X-Gm-Features: AVHnY4KLRzlUmrPHUeRVKIxDjXlhTrNpjx-QgHfeD3GnLnTD_AraTJFEErroZvg
Message-ID: <CANUHTR85p3p0a1QL=GOTOgwy9QtS4dDS8yHx_Rq7QFwSskZvMA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Fix use-after-free in path files cleanup
To: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Vaishali Thakkar <vaishali.thakkar@ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 00DC050E683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20391-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Leon,

Thanks for reviewing.

On Mon, 11 May 2026 at 19:36, Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Apr 28, 2026 at 06:55:15PM +0800, Guangshuo Li wrote:
> > Once kobject_put() is called on srv_path->kobj, the release callback may
> > be triggered and srv_path may be freed. Therefore, srv_path must not be
> > dereferenced after kobject_put(&srv_path->kobj).
> >
> > However, both rtrs_srv_create_path_files() and
> > rtrs_srv_destroy_path_files() call
> > rtrs_srv_destroy_once_sysfs_root_folders() after
> > kobject_put(&srv_path->kobj). The helper dereferences srv_path to get
> > srv_path->srv, which can lead to a use-after-free.
> >
> > Fix this by calling the sysfs root folder cleanup helper before
> > kobject_put(&srv_path->kobj), so srv_path is still valid when the helper
> > accesses it.
>
> This sentence is unclear. The srv_path reference appears many lines after
> rtrs_srv_destroy_path_files(). What exactly is the issue you are addressing
> here?
>
> Thanks

I agree the commit
message is not clear enough; I will send a v2 to clarify this.

Thanks

