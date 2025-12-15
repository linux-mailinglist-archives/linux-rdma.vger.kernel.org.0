Return-Path: <linux-rdma+bounces-14998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE65CBE321
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13732300F33F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6762D94BF;
	Mon, 15 Dec 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mY6XLWLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52203314D0
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807787; cv=none; b=i19/AbBTTAtbSacDONGYeDsqIhygFtXRlYB/QUcy9zCNA3BCP8usVN8dY4+GczeBhSvADEAwX0eNJ7azyiD9qaS9MI9Un8Y34aAmrg0edB3/zybS6/Or/X241kKqVkMINBc/rBXqTgXLj99J5/2N8FD9JtVeDoHQCeGNZB4h2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807787; c=relaxed/simple;
	bh=a5hF4QBR+ZhlAFZc1a4Tnj7bIyil6UNwxw/cBS7TTfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTb9eOcAV0DUIPC95W8wZUg4hQiNy49yheTVeoDvH7prJTnaIm9FGziwUoyMeCVfFci+y8Ig5in8z/Kx3f4Gx4XXgBQLSm+LPDRAn2M1FkXfUIsghAFAOTcyC19FN/ZgCapZ34SOEOy9tONXwnVWR0o+By6r30b1NnVZc8q62/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mY6XLWLm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632b0621so25320835e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765807783; x=1766412583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc/35n7eOAP8pFt55syhr1wbpjAJtoSwVCMNoOaa6ls=;
        b=mY6XLWLmOjwPh1HcltXU1I9yEOOx9shXwvGhp+uyoBeTLT+o2P5RjrZDvhyvgKG7v1
         EfznDC0/REn7YEd/VKbtaJHjA8NNGnClDuoB8OALi/9G0LvmgkSwt6fCiySrtsO1a680
         D3nJ8w1vqwobT/CzvnFNhllqb5fWu2nSKKBDcWud5Hj3EW4c3wj4bpNNk9leudWTRmGj
         aJR+WS5Xb9jtj36uSurGgInmn03tAsd5TL5KfvaV12Ap6Xtso2/KFIxz5GcS5UWW4yUu
         +j/9Ci0j/xPGYaZ21xH85e7LhPQnlXtTJ2QcbHiBHfGMCpvb53LRgbBCtn7verGqP9jf
         yj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765807783; x=1766412583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc/35n7eOAP8pFt55syhr1wbpjAJtoSwVCMNoOaa6ls=;
        b=HA2TcMlDsBQQDGc+gerctUkP7c6z+xJzFBN5POpfsPhBJG/smLFzf7Z52rg2zvykHQ
         DSShHwkBNE01y+IUorB6UI+AgCicGhOZda0IzNkxlccNrHM475piiuEgEfVGSili2ODG
         EumKD2YrSlRxmmB/BWp9kjAhutwqvDAquWqT1HcepjYNiWQjvnsPH5Ykui67v6CcMEo+
         c5L9rJ7OzvYSnoTVLRtn/w3gqwP0mnbl4tfn3nPjDujtOkMwl5bhR5BOC6li7rKD6aNS
         ScRCufM+vSWJzqD5RgUl/+lisrfI0B6PCf0tTwmsXjPcN7uTCqjWCkJKABoRsbOLMLnO
         qz/A==
X-Forwarded-Encrypted: i=1; AJvYcCX6EoJxxXGDaakdiBPTObYoFufTa7F+3uwFYnzbVLnRgaFIS4o+foFNgQdD/hvEfLL52OXMX+EfSa6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOPafyN9FSZCuPLHMabYQ1ShvI8u7RgFLMP2KLGwTJBthpm7f
	xvtmlcQmFdKfBah7zY7XqkvVIys+eDLFoeynFxlRQ+mH2BevZ7JWlRAuBOdEdZ2XXDs=
X-Gm-Gg: AY/fxX5TCghU25nurNmZ9dyr8bRdSRebB7zEcAtjeeLrBvpVZOJAPxpQ83ycjD/0FHL
	l5bQivu5QtMJ6QHNNiiVcMXALrc9dHXJA8hwZVHWHIclSd/LHT/12pzPBSuVrRqfTv/zsf/Zd0X
	VTYlWpmCk/0JTVFNEm1ASo2t50Y2PCDa7LNMNmd7shjZVBExmB125GW/EHJvbzA5ey4zDDM8p8h
	C4elKh99nPsxY5j86n43C2wGSWx6BGcShEds1Pvu9vqKyIHf3TsUJfYh17kGar1BZZNnFrUDvsT
	Uz8oeJAp8XoXJUaPzh4zor9aXn8AMNmT6Khu6dBoLE2SI18wTHI8yIPPRC3MsnYiOO0C/zxnn+/
	1N3F8wtB/Ox5IrpsKh30K7L9busCMDRKgdzXkP5r/By7S5uvo7PCO8wzF8RnBPPG4Xk2O55VTo7
	FkGu2E8KcmdO6A202idd7UKFY=
X-Google-Smtp-Source: AGHT+IFJ7XhIHXbaOzx1TEAlEfyUnyEwSWzsivaISUhktsBUoRVHQJCmyr0qoXUugUvu/YlkS2NEog==
X-Received: by 2002:a05:600c:3e85:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-47a8f90cffemr109935815e9.29.1765807782193;
        Mon, 15 Dec 2025 06:09:42 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b17bsm192749655e9.2.2025.12.15.06.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:09:41 -0800 (PST)
Date: Mon, 15 Dec 2025 15:09:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 02/13] dpll: Allow registering pin with
 firmware node
Message-ID: <dssuif6sbx7zp6pkk6divo4qceyopcq4rijkvqu7wmtqegucnd@etq3m2vvolo4>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-3-ivecera@redhat.com>
 <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
 <3E2869EC-61B3-40DA-98E2-CD9543424468@redhat.com>
 <tawd6udewifjeoymxkfkapxgcgfviixb4zgcjnplycigk5ffws@rdymwt2hknsl>
 <eee9be12-603d-4e8e-92f8-e76728974313@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee9be12-603d-4e8e-92f8-e76728974313@redhat.com>

Mon, Dec 15, 2025 at 02:51:36PM +0100, ivecera@redhat.com wrote:
>On 12/15/25 2:08 PM, Jiri Pirko wrote:
>> Sun, Dec 14, 2025 at 08:35:01PM +0100, ivecera@redhat.com wrote:
>> > 
>> > 
>> > On December 12, 2025 12:25:12 PM GMT+01:00, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat.com wrote:
>> > > 
>> > > [..]
>> > > 
>> > > > @@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>> > > >   */
>> > > > struct dpll_pin *
>> > > > dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>> > > > -	     const struct dpll_pin_properties *prop)
>> > > > +	     const struct dpll_pin_properties *prop,
>> > > > +	     struct fwnode_handle *fwnode)
>> > > > {
>> > > > 	struct dpll_pin *pos, *ret = NULL;
>> > > > 	unsigned long i;
>> > > > @@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>> > > > 	xa_for_each(&dpll_pin_xa, i, pos) {
>> > > > 		if (pos->clock_id == clock_id &&
>> > > > 		    pos->pin_idx == pin_idx &&
>> > > > -		    pos->module == module) {
>> > > > +		    pos->module == module &&
>> > > > +		    pos->fwnode == fwnode) {
>> > > 
>> > > Is fwnode part of the key? Doesn't look to me like that. Then you can
>> > > have a simple helper to set fwnode on struct dpll_pin *, and leave
>> > > dpll_pin_get() out of this, no?
>> > 
>> > IMHO yes, because particular fwnode identifies exact dpll pin, so
>> > I think it should be a part of the key.
>> 
>> The key items serve for userspace identification purposes as well. For
>> that, fwnode is non-sense.
>> fwnode identifies exact pin, that is nice. But is it the only
>> differentiator among other key items? I don't expect so.
>
>From this point of view, not. I will not touch dpll_pin_get() and rather
>use new helper like dpll_pin_fwnode_set(), ok?

Yes please. Thanks!


>
>Thanks,
>Ivan
>

