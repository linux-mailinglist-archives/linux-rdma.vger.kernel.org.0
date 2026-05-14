Return-Path: <linux-rdma+bounces-20675-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AdoNKubBWrAYwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20675-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:53:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B7540031
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3453C3014FD2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6773A6EEB;
	Thu, 14 May 2026 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNDX+nEg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rfz4c17j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A838E8D2
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752425; cv=none; b=iptkHQYvooKP2+kAN+B3lOQRwZmitoviN6tGZp8uCFlEQ9JxACdX7Ci6wgOYeXpAWByCC+0uR1fH8CzUv2ohH7cUK/C1FGl0UApj2lgvxYqRelPqvzm7cZVdwISH7tEogtg4S5l5ZIy6ZhTOx+JbtScOh2RqZccuGmp0OzF+c+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752425; c=relaxed/simple;
	bh=QrjK6BQ59ep/1bMn2obVpOo9paaD/nkuAL/gEMrLF8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxsvinKjsysipjRBu5OxmHvVzMx5byPNyX5biYsUiRrNlyISKUmHltRHegR5ANR9jX9lKeqO0bcspRMuXkWqPIgXQ+XuENlAwWrmkLnxkQjUhd2GLPOcwcSG4YK8Vb37rITY9A+8dvxreZ/XbhrmwvZqMKCcDrTz+m9Mgoftn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNDX+nEg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rfz4c17j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778752422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
	b=MNDX+nEgmKXLXcIYCJl3igSoO0D+obFAcP0uvHiEZmS46d8o7uD+hW8SrO2jhkjza2LVJb
	Rc4AtjZEzIxxssxYl2vphnyWO3+RVHG4sBNim60xmthqqVFi8/sGq6MSa9AhRBDKDlDFAf
	0vfJdV2BdNonrTC9WHmGeNojz9AnnJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-OgB8aIgRO5Wl9jw-3jP9_A-1; Thu, 14 May 2026 05:53:41 -0400
X-MC-Unique: OgB8aIgRO5Wl9jw-3jP9_A-1
X-Mimecast-MFC-AGG-ID: OgB8aIgRO5Wl9jw-3jP9_A_1778752420
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d144d3428so45412955e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778752420; x=1779357220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
        b=rfz4c17jyomiL5Q/6HL0BsLcxBtuwOiAXbQk7z8tvJdAZ9rXR1jL2h06zWzqF83T01
         HWH0ITtlTeKqFOf/tJiKR9ZA/W/jOR+EOQkQhRaxWrT1ym6Os/k4vrgmYr5WiRg7/Glk
         lGObzeqXuU6v+QBffl2807mgMsOyp5vZqOE/AoqEH69prxKG+huiyUu8pD8LL7D1wyJe
         w6DYosDIHpm2hxBMCIVPn+8Kar+rnbNMj6N7oy2TK+0wJRaIm9IfaBi9HX5BQsaikosf
         L8WTufrMeFFbw3qBd9bGvlyeJA7nKZIOx8wYrXEJuuTmKRXsDwsIbr6MvVnVzrasJQhn
         ibPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752420; x=1779357220;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
        b=bmEThxTY3wkAPZdfXAjBi8wtAA4Lcs+lMKIsaAINEnz3a3MiSicz/9icqxa10Qb2SH
         kb9sssmVxuP4mO2iVS6hJPG2Qy/QCvOaJALKBayUxWPWec73BroqgeXZaAxp9kzkA+je
         pDWSLTVKpJA+d3I00InoPyhe6N1VZz0XynR6rCpOVinGvlTM1cmreHr+6IYylABgiWPd
         NXXzts5jIQyjaVePD2FFg2v8D6EVS3RKYUAnA0AAQjO8m5olvc0YKI6h7GBwQ7BYzug6
         ovZhjrOiK5jjhS4QV0A9nSTImKpahFWFAY6jA445mk+Ejku2Ch5ZcrmmDKTHXSiDTY79
         e7gw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZnxLGOdW+qK+zEUBhFq6z0r7k6mAiT+pWY+kNWl1IcTN+BJT8hpGpaTu7Lm3U5E5HsqMZ5QjkT/3B@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2BvinNISWc9UmNtWeWH8BqUI13d/73D1u0esho5XohZvHh9d
	9pTlEeKccFhiiYJVOKhTte9v6qoD9/GRfn8EupDtGscxDC8iKSaOx5IxYh7zvmWGC+jPiLIV0kW
	VFQeEqRFAZHeEN9YVICXyO663XfN8lK2KmehKpuO56qSiDvrMtJfAOU2Q0iEjla8=
X-Gm-Gg: Acq92OGrab1sUlS8xR5sOeiFExp04mTKaKMNdoGiX0DcX3n5FZlYqobiujk3LOd4EqM
	9E1buIh4xp5S0QkU0r3RZGb905hpRXCQVuwgi3FrpVb6Qg/r0qq9e6GkSakeFNHKrH+d49NFtlE
	VzT0MnslP2I1TVJSm+UP+LXo3pLmQxge2hWRjhu6+4fUCqyj09edw20v9aQA/AojyR/SP9BOY0t
	oKw37aV1DkySxkEy1HXQkzMmSxN/vN5TCxd/hx2kyWHDyg5v/pxX/t36Junn0KGoIlRvIYwSuvc
	ubGL/vbZNruXyZpn6KrOnw97M46iRyH7JJmDAQScp77D3U2oFeNV5+RVkrmsiNIAqGgV85FfVNk
	MMpGAkX57avjP99YgZAHrMFk0AcXB3aDZtnyr0+Qet/pPyO6ttt9yv+g=
X-Received: by 2002:a05:600c:a11a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48fc9a143afmr81776895e9.11.1778752420307;
        Thu, 14 May 2026 02:53:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a11a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48fc9a143afmr81776595e9.11.1778752419903;
        Thu, 14 May 2026 02:53:39 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498a7esm50954115e9.4.2026.05.14.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:53:39 -0700 (PDT)
Message-ID: <a0d4052c-2e8d-4dec-afcb-c8050f5d1ac7@redhat.com>
Date: Thu, 14 May 2026 11:53:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for
 satellite PF support
To: Moshe Shemesh <moshe@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Akiva Goldberger <agoldberger@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260513192539.7fd96592@kernel.org>
 <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD2B7540031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20675-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 9:56 AM, Moshe Shemesh wrote:
> On 5/14/2026 5:25 AM, Jakub Kicinski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Sun, 10 May 2026 08:34:40 +0300 Tariq Toukan wrote:
>>> This series prepares the mlx5 eswitch command interface and vport
>>> infrastructure for satellite PF support.
>>
>> Could you perhaps start by explaining what "satellite PF" is?
>> And how it differs from "socket direct"
> 
> Satellite PF is another type of Physical Function, its role and 
> privileges are similar to the host PF, but unlike host PF the Satellite 
> PF is on the DPU and not on another host. So it's kind of "Satellite" 
> for the ECPF which is also on the DPU.
> 
> The next patchset will introduce the Satellite PF, while this patchset 
> only does some preparations. Small changes to prepare the eswitch to 
> manage another PF.
> 
> While Socket Direct is a hardware PCIe topology, that adds another PCIe 
> link to the NIC, the Satellite PF is just logical entity, by firmware 
> configuration, no hardware change.

My understanding is that Jakub wants you to capture the above info in
the cover letter.

Thanks,

Paolo


