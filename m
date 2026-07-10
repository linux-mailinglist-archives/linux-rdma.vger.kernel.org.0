Return-Path: <linux-rdma+bounces-23010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICY8HXwiUWoh/wIAu9opvQ
	(envelope-from <linux-rdma+bounces-23010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:49:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1873CB59
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=AyS1Bxmo;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23010-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23010-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC2CA3099FDB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4043C076;
	Fri, 10 Jul 2026 16:43:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C943B4B6
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:43:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701830; cv=none; b=pSUlURLxNLC1fBspLxeP0+4PR8i64G5Fy04RjBiQdYuyDXRhghDo9D73IkOAcMpVpL1rS1Hbkq+Ky7AB2K71z1v8iXBFObPvEEVDLA3gx6WUmEmtk04b5ohIK1jitHoBON/jaIcIxS4/SP/mELIT6fTStFhnzO0NDiOD/9siFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701830; c=relaxed/simple;
	bh=uIhVIgctXUQcWy00AudXCG6kW+KyBF/3q5iL5v2zEVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS8ZOctCOjN+D9VIfCqv0V+a0jow9xOUB/Tv/ArLImSJUs8bs4vI1bqrhXq2uQXUhLXXDgVt/f9qX6jTtOfV/Ce7ScEJLZ6GwXXtHouYtmXeAGOEk0F15LGiKAjMzhu+9oOeK/nG2i9AAgT2oCdHV5Zd3eOI5LhiebJYPIgY3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AyS1Bxmo; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-920f33347f5so58828585a.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701827; x=1784306627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
        b=AyS1Bxmo0N6YHkVKH9oyazzctAf/4C32alIBv/QFTAAa8UmyfwpnYGzVReGFWv+DP3
         VcpePWyG1bS/CSWG/+IpVMdTuFeZrVes+MBNYw+9jRJF8pK+0K9aHMt4bLIgaQ/7/9hy
         VEfaWMdWITdKdLpPAeSE7Qtwa29EwC4oxt3cBiOlEwjIPNBgoy3jXc7Geh1fAHMdfQfZ
         Kmmja0r7dBY5Rh+6mWUg0+qVA8QOzx1s2Y0bHZcGk6L+fiUylkBBPLREklZMk2T+VfcS
         x9bojoZx144A8gDBS9ilm5M0wynR0XIEzLUj2z+6xCiHnXv+Il1atWK2ekrdouHfCya1
         A7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701827; x=1784306627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
        b=MZbn5S+dkdD4m2BgL1r+9WsLu5j4jkk8Sr7yFPXdaBRdP7ehElkD54BMVEO75AJZPq
         j2S8Eeb2Wy0pP/Qx6UjOfGAAWAjDiybZvb1oje0mHUPNvPscH8rY4KVF8sdBCPFKMqxn
         lz9N/NKQDuoIDN4a7zjDt3k5hW27w3n+2dvZGOrqq3u9wQvMZzJl+rOJBPBLL8Luo6d0
         FX7KlV5GHOnyB/q8hzTeunfRsgEIibQeJf7geFntauK9a4pBg/tfY/CXE7B7LgehijEL
         GsXs1uNEE4Yv9PuXFtKsmLgFw2HDdbbZ91PfvEfd2ITwqHyUiBuUL7m2p0t6LKQAwA9h
         CoGg==
X-Forwarded-Encrypted: i=1; AHgh+Rrguk+ZdgB+QEwOGvRKIidOtH7ja45r5kIUdvT5g1MQMPYjmuM14bIGIwrZ43sZXSFbRXIDF+g9CRHu@vger.kernel.org
X-Gm-Message-State: AOJu0YymbEbA1cLblni9NpgDCBC4cJHqMf+cxjbu0dkLla1vocKI2/nv
	CnY3+fvAXBidGPWGkZd4OPymL4C7onDurmLRkophQKsfO8qG2QGbtAKgotRUZeZDm54=
X-Gm-Gg: AfdE7cnHZfK7QW4BT0SJfl0Q0YDngu5AGir2G4wsbBmAa/5c7auDsFXCvSpV94skvU5
	osPCEaQr9Orgmcxol1K1hWB5vfEULxjFyfH/euFXBbg48TMeVRpytPQ5pbMBh6uDH9HUePn7J+h
	u2oHN7TG0ZmpS4PmgnzHIwFFkHtLvJO7UbT/ybqSim5FViM6UoCSdT/cHU2LJxZNnbkGl8to9po
	6RqRXQLPNNA748zaIKBnW9VacNSy5E7+/36vG3DyTjcz8/2dxT1pCxLDIN1BC612L+Y5h9E9t+t
	GtnOF3Lmk3GKi3atYWpVsWsqZCdgUezhEJnk602vt2G+iKg5bFHgT2YQZvemPkYwtQ1HrZTdn2+
	F9BkJqCNLvJhpkHxC9U+64q6kZPK8DE/Okv5MzEAtxUg6in8Z9F4TZf2IQFiu0GJqXdyszo0=
X-Received: by 2002:a05:620a:240f:20b0:92e:e569:dc20 with SMTP id af79cd13be357-92ee569e3c8mr347342685a.78.1783701827057;
        Fri, 10 Jul 2026 09:43:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee59223e7sm237517985a.0.2026.07.10.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:43:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEKH-00000007YpZ-3qzk;
	Fri, 10 Jul 2026 13:43:45 -0300
Date: Fri, 10 Jul 2026 13:43:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-ID: <20260710164345.GV118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345365679.660027.16671418103486907555.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345365679.660027.16671418103486907555.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23010-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8E1873CB59

On Tue, Jul 07, 2026 at 12:47:36PM -0700, Stanislav Kinsburskii wrote:
> aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
> It keeps a single HMM_RANGE_DEFAULT_TIMEOUT deadline for the populate pass
> and retries -EBUSY until that deadline expires.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes mapp->range.notifier_seq for its internal
> retries. Pass the remaining jiffies from the existing deadline to HMM,
> while preserving the driver's existing outer loop for interval invalidation
> retries and for selecting the next invalid mapping.
> 
> Keep returning -ETIME when the retry budget expires, matching the driver's
> existing timeout error convention.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

