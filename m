Return-Path: <linux-rdma+bounces-695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA939837188
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC441C2AA26
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E253816;
	Mon, 22 Jan 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V4q4M9i1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048D53812
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948516; cv=none; b=sd9vV0W33WW/paAP6ir7u/dO3RcyauZzxKfECH2H8QmpcmDVbFa7BW968ek0PbcnlgpPMetZaVlgdc1cGNWhsafefEPkqznhTtq0ZmrAILGLKY5sSKRXcqL/qqr4x4lPWqIl8jiQJi3MmM9uBtTeEuGIru2rHCLJke53xzWPtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948516; c=relaxed/simple;
	bh=uiV3WuhgKYhvC4P07qcYRiFH3rHnoR+9ZARkM4/fj0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5XQ7HTuyYCkRlbSlqPe9L0QfPL6O/9KHT6Sd8F+pGZggSwSt+r0vivaMv7fQ5IImJoRfyj1DkcEX8IsDDWs3fdgqmrB/7nKjpAK3WXZf9dEyXiBGJc64CyCe20cQiEmmzG3rLwW4LjWHv5+Vj8CbBTOdS3IVTwNei+B4voyDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V4q4M9i1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59998b4db22so335933eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705948514; x=1706553314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=biwVmpyh6cDqw2NfryFFlfeownZ81WLQBGDjXboq7Gc=;
        b=V4q4M9i1dHN5s+v/SYwAm3inFnpggsr9s4eD5yKEDQYngicRrk7KSuX2PsIDl4if0a
         jb4o35oWC5Oc05PwmgV1v+5YwtHptZq/W5Qz5GgppcodWr2dlUynQ2GbbB0TeASAXN5D
         VdDHRSi4TyWxovK8Qw2g2F4lYlSlLc3/oRzzyrfmCCBqsS383IUeAIVA2X/7Bh0Jfh4e
         c+gfbwdco5x46NF9yG1YzO9eSrPU53BAgdHvY6V9P5zDZJgFwIj5xeFNdog7yW6NaoOt
         Mm2Fyd2krItSPwOQMOFm4aGZTMor3X285CYh31ozF36xVNZqNt8Af4Y3qYWlSNBdGR8o
         yirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948514; x=1706553314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biwVmpyh6cDqw2NfryFFlfeownZ81WLQBGDjXboq7Gc=;
        b=PwVZ4zxBBOyToKTHLNHB2zoOPpvx1xOvol5j6+9+/UWUWqLuUzLlAkvyB/n3BLN71b
         MTGDjbfuhOKAveepm15+HrJ3DEIQIY8y3aq8rv9uHs+MSbYjH9EwKPAqopCC8h6QYRH7
         zVgDVrsMiXOb5MkW4XNp4bisPDf7gM8LzKqAjZyZmjAaqf4BPa/RssBhJj5+N9Gt+aWU
         YqKiSutlY4vM9Zv5epbAJ6+zcpU9WJthiQ2xhLOEkV5djJRFxvwV0II4xwXWbtT+g7IT
         MeQJFRls3O8fIHhLNiuhvdE9gB1ttkeKttDINBdSudR/HM2CK0oLcYK1VZcUI8/LoKLB
         COdQ==
X-Gm-Message-State: AOJu0YwwVbJiz1Qo0yYqJZ7YEE15YIkpjChMj2/juGGzh07iuyjCsqU+
	MWIlVi8PJ7OWwBIOsy3Inf2AUSRnC9t/ciBlVGozKdylWm6H20QYZtSsMKoHVao=
X-Google-Smtp-Source: AGHT+IHrW+zyu5C4xptaf+HWPR3kqrmQJQXFpqmegIRS06ZMvr5hJW1fStzuLOWhtaqPG+NHfdC+Dw==
X-Received: by 2002:a05:6820:407:b0:599:99d2:9506 with SMTP id o7-20020a056820040700b0059999d29506mr811564oou.13.1705948513996;
        Mon, 22 Jan 2024 10:35:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o17-20020a4ad491000000b0058a193dbc7fsm4175760oos.15.2024.01.22.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:35:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rRz8a-006xry-K6;
	Mon, 22 Jan 2024 14:35:12 -0400
Date: Mon, 22 Jan 2024 14:35:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mark Haywood <mark.haywood@oracle.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: bacm address config file no longer generated by service
Message-ID: <20240122183512.GQ50608@ziepe.ca>
References: <1ad5dadb-f6c6-40cf-83cf-f269233d8cfd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad5dadb-f6c6-40cf-83cf-f269233d8cfd@oracle.com>

On Thu, Jan 18, 2024 at 04:54:16PM -0500, Mark Haywood wrote:
> I see that the ibacm address configuration file,
> /etc/rdma/ibacm_addr.cfg, is no longer generated by the ibacm service.
> This change in behavior occurred as a result of service hardening
> implemented by patch https://github.com/linux-rdma/rdma-core/commit/c719619aaa0ec2651edc4e5dee9f5ff81208b185.
> 
> The patch hardened the ibacm service by adding the following options to
> ibacm.service:
> 
> > ProtectSystem=full
> > ProtectHome=true
> > ProtectHostname=true
> > ProtectKernelLogs=true
> 
> ProtectSystem=full setting makes /etc read-only for processes invoked by
> the ibacm service.
> 
> As a result, the code that generates the address configuration file (if
> it does not exist) fails:
> 
> static FILE *acm_open_addr_file(void)
> {
>         FILE *f;
> 
>         if ((f = fopen(addr_file, "r")))
>                  return f;
> 
>         acm_log(0, "notice - generating %s file\n", addr_file);
>         if (!(f = popen(acme, "r"))) {
>                 acm_log(0, "ERROR - cannot generate %s\n", addr_file);
>                 return NULL;
>         }
> 
>         pclose(f);
>         return fopen(addr_file, "r");
> }
> 
> The popen() code above is supposed to generate the file if it does not
> exist (i.e., fails the first fopen()). The popen() now fails as a result
> of the ProtectSystem option setting.
> 
> ibacm(8) does say "If the address file cannot be found, the ibacm
> service will attempt to create one using default values."
> 
> I guess my question is simply was this change in behavior expected? Are
> admins expected to run ib_acme to generate the address configuration
> file prior to starting the ibacm service?

I don't think it is intentional, but it seems like the right course of
action to me.

daemons should not write to /etc/. There are many good reasons for
that.

> Is the popen() code in acm_open_addr_file() being left in place in case
> an admin decides to remove the ProtectSystem option from the
> ibacm.service file?

No, I think it was just missed

Jason

