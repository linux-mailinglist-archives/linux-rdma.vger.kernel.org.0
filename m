Return-Path: <linux-rdma+bounces-16752-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KwpO6F6jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16752-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:48:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E33124845
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FEDC3004624
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0D312829;
	Wed, 11 Feb 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KEWqU1eO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD953350A03
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814108; cv=none; b=UMoGT/kW4UbLf1YepX80Rc/j3tpR6kYuKy8uGpkh9y0fBWSC8LD2gDmkpz/xz8FOTcNEpj/q/dVbHfzkG/GPuSTqukuwD3tW2B5z0mTH61HnKHCLQELe67TcvlRN14JWZkxz/iTGSHHlwQV4cNAApW7eUVEU47zYi6Ettb2POFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814108; c=relaxed/simple;
	bh=MTEtVdb+ErOE/e7gGU5eKC87aTkA+gVA8DpKFhPYYqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcXefM5WGeG/eZ+g5B/Swz0b7BYKIhPoGba/SuPitfaFCaVlOog+oWEuuo+upHtg4W3wRSxABhKES3H3yFpAGT2dVU9OVufvc1ox1z+1xbsCAjQ41sKiXnulTWVruQQTQ2jsZ0XZv2IpZ1BXMbFBQG83r+Y2Z/OmertSzdfvIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KEWqU1eO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8954c181830so49825366d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770814106; x=1771418906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTEtVdb+ErOE/e7gGU5eKC87aTkA+gVA8DpKFhPYYqY=;
        b=KEWqU1eO88H4/DtMarnKR2FEm1i8xI9nySnZPhRWtDNfuVEL3mZP/bmVy/XYbyiH9p
         EpNFpFc92TLToErZrW6IVwXQPm8U7jjRUjhv0vV2UevqvOfPNKgMlYiiiE+FW7/Rds3L
         V18akdC37HqwE/JS77nO6Mwfain07eek1EyIcANG3mrQM0U7qiihJoUCIJu+4OVvSFoz
         m6eIVeOnx+NbCxu9736A2BYQrQZm/3UnFi6w4ODzhXo5feQCs2ILRPWHPgpOIKVysrwn
         Bj2/8UB/ATWV2TJ85Z+2KQ5CZTc5TMpAfVR5FOoU4nCmRa7t/IMmNvdSfmMS8YZ1PgO9
         K/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814106; x=1771418906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTEtVdb+ErOE/e7gGU5eKC87aTkA+gVA8DpKFhPYYqY=;
        b=sNf2EButncrk+YNu8OQaeY1WbjxgXt3/TTUenJL5nwrngUhfQHJ1Jf80a6wWYZRy+E
         XYyAmag3WTDkvTGqb7AJagWg1pYse8Um16/41G2Qx4NOO5tYORcI5PkjpuywkaYFjye6
         vdkIN7mLKq6/LEMvjDV1eDbTbbAd5HAblmPcHjVYJO0g9r49xZp4Q32VbWF0eOa7a50y
         /1I5XlFzw+QQaRv8uf6P5t7J61/4L13p597VJC3ujz19dn61JsHhlV5dv7XvYpKwDWJ1
         fM+8FNS6zYNID47g/3UklfM+XFWzOtWOXfa/WgKPu8jxLcBVWoiio40VqY4BHjUXWqND
         VJXA==
X-Forwarded-Encrypted: i=1; AJvYcCWy0gLzvQIs6twTQJ6+AZtKQ29wrKH83tVy2vHbM6waVRRcizM9yy5qvv7VKV+DOU74ePkLcSnbVrye@vger.kernel.org
X-Gm-Message-State: AOJu0YybVaWiDYmnQS5aL336cJbVRfY3rdAhB3DHNUYLLaHPCQuZ0qZH
	0+L0DBE/Sgql0roqqg7QVeg4AlwzkoIvYGuIEs1mkQ0mLRrh3BUUrZsolfXtDwMAQHsjMSJzVQ+
	9phpb
X-Gm-Gg: AZuq6aIArz6YIpoxGhP/oi0T/fRH7E9yjGi+vIDILLJgfQirHDd1ZvhK0tGl24WY0FI
	uZFgXF4epDqsaWKePOI4t7imTW+d/ydpjv4oHpj9vGKtLWrST4xR0FhEbzpvitg9EI93H5cAFvf
	pNfKtjOcmbQ5CHt+XYVfEpSoVQHs3bUftPvk0+iRJBFA7H1IDnKZNPo9yNc0uw0qTmS6as9eKcv
	IfKYKZd4f/y1gnvElNpwscGSIzQTaH3oeiYc7QEkv+zFTB1U6lquFdkqkUuBeIhUyOms4YjCyNA
	UIyofkZB+gz5UR33bG0/H8yRaklzIvJXrj3blQLqj1S8AAX+F30exFtO/rcfOaWEbxwejURyKCV
	fhln8QukHDnTedELdWqrs1+z+B7SxFyPktEyQ9LZV6/SBdjJj1/DuWfdayS4a20LA6VLTrB8OIP
	Uazld+RXWS9QY+R78X1Jj1PcyySezvxypttXD/qECyOdJOp8Y+1laYczKIwPW+g4vKOyaNWXglA
	+VjNIw=
X-Received: by 2002:a05:6214:1cca:b0:894:8311:d3ef with SMTP id 6a1803df08f44-8971b165735mr34330476d6.69.1770814105662;
        Wed, 11 Feb 2026 04:48:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d6f55sm13202821cf.5.2026.02.11.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:48:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vq9do-0000000ALUF-1ZlU;
	Wed, 11 Feb 2026 08:48:24 -0400
Date: Wed, 11 Feb 2026 08:48:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v11 4/6] RDMA/bnxt_re: Refactor
 bnxt_re_create_cq()
Message-ID: <20260211124824.GH750753@ziepe.ca>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
 <20260210165939.41625-5-sriharsha.basavapatna@broadcom.com>
 <20260210190750.GD750753@ziepe.ca>
 <CAHHeUGUSL9_p9JzY6+-B+RXDa55KfWCWmP7iV1K7_NVcCuMqVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGUSL9_p9JzY6+-B+RXDa55KfWCWmP7iV1K7_NVcCuMqVQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16752-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08E33124845
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 04:55:28PM +0530, Sriharsha Basavapatna wrote:
> Agreed; is it ok to do this clean up as a separate patch (or series)
> later, since it is not related to this series? And since it also
> involves several callers of bnxt_qplib_alloc_init_hwq()?

Yes do it later

Jason

