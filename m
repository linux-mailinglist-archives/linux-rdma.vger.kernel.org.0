Return-Path: <linux-rdma+bounces-1431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FA87BC0D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA981287E61
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520C6EB70;
	Thu, 14 Mar 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMMraK/A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB246CDB5;
	Thu, 14 Mar 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416385; cv=none; b=MoV15FVUZahH+KM/hZ94KIEm7WjNcNTqTZtbEgXjv7A2OJ7eC/UM4LPVbGT4fTK0dUwLEh/8BWHDKBXjQbfU+MSkTzuWbHrSTAb0FtYq+xxhw3JE+G8RB+udESEGUE+BJqrpNS9rADL4yWgKovhN3GBHo1JyVc2kRR1dih24iC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416385; c=relaxed/simple;
	bh=ETF4crk2ZZn+GTdZSouP+pIboaWYhShSjz0BQ9XdVLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aelnob23XcVokIZUMkVd76xKRrnTEqu0JV5w02y6mnce+Vjk9Jd3BpwaW0rx0wKu1IIbR2vMFEMHNt9YCo2hENDfTVQl2g+fZzCZIzboh1MUzogShCjAk6TMtARa+DdjSQJ7Drvy6e4sg4fupDcG1JiuSBxfH1wy9L6W/MVyg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMMraK/A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ccd69ebcso380049b3a.0;
        Thu, 14 Mar 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710416383; x=1711021183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfQgWYQyYj89ysjrRhexn30LYxihC3kxhP3AI5S3jLo=;
        b=fMMraK/AkYSmmwVzgEFN+40yGYq/SPlhRsa/lAW0JQ1lWD74NWV6nA+fhcFU9Gdsu8
         IXqgTFkjgLilKdYezeH8BI/ndaPrhoHsC4MbkylKvysqrRp56O7iw5VAuN6iA1n/ibeg
         83yK7etj9/txu94lUYsjc0pcIYjnXuQVxFv6i6wRlNJOUfdzxpGsH9pNCORtNkZu4dvC
         5nkXr1X8Y45kExvzaKQzUHH0kv4E/3TFIj2avpRT1xZRnGZzjcK0y9b3ff50+mOMga6Y
         eQA5Aui12TR8FeK+Zr3LfscUs+nRrJnOyDVrWHZmy1PGeHNKEgL2iFlADosKG0PtKwM5
         Jmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710416383; x=1711021183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfQgWYQyYj89ysjrRhexn30LYxihC3kxhP3AI5S3jLo=;
        b=A9ZB7eqjfgFuYsvBpBXk3i1bkTVjjiz4CMLEfZDW6uWbusKSXokHNJdkSyuEBb5iW6
         Lbam3zVIYqSI+Hg5KlIHsotQhLgUYIYuE1JCBXB7yyR1itcY6MSvPTtuaYp6kTPpGuzb
         lcCxCte4XOGgRxTEGnjePfJD+Atw52mGpJ8KQZl48Yvgl+MHMU5UeWMdwf/MOYJqTLri
         DqTH6i5VqxxA6ThBysqyvsn8m7DhBOOv1plOcQUmuqdYYhxnHd0ub94RpnlswnWB5+MX
         Pz4n+sDxic2ao12DxQu4BurN5KtTfMADZNrb+bap8WRQA8elUJWPr1wabGPdTog4wjt5
         r7gw==
X-Forwarded-Encrypted: i=1; AJvYcCV4sDi4UBTXNKjiHWuWoeNgy0QnCvWAGuXXv5fiuvlhSpQAe/WD12dp/25uNArV4ldEd7cy42BgDHqkn5xuwXxefx+G7tN+YwR4b9svzKO0N1U83WgkNgUcx4u0ofp2R6Xkd95OCcmqs1PwtcOAOl/Q92mDmR/WOLHyRW80rIlwYw==
X-Gm-Message-State: AOJu0YzobbrHguGysuXTpNUJvWGf/76KtQXG+LK6XV6pINF4p42drIMP
	+x4mNHsbhnpsIXRBiWC06+ZtBi56dIUtsSMgNZADzmBHX8/4KLqA
X-Google-Smtp-Source: AGHT+IHLaKlI2bpVtlmtYb2ia4Zt/JCYONAdDifdpN67PuRuSJBTUazfb6ou5fCqmlhZHkUJgKP0pg==
X-Received: by 2002:a05:6a21:18e:b0:1a1:6f4f:25e2 with SMTP id le14-20020a056a21018e00b001a16f4f25e2mr1651524pzb.49.1710416383169;
        Thu, 14 Mar 2024 04:39:43 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id mr20-20020a17090b239400b0029b9cb71e22sm679670pjb.27.2024.03.14.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:39:42 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:39:38 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
	"Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: net/rds: Improper memory ordering semantic in release_in_xmit()
Message-ID: <ZfLh+va60YU2U86q@libra05>
References: <Zehp16cKYeGWknJs@libra05>
 <86d88699e8f22ebe0d45ffb5229fb73d78c5aae9.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86d88699e8f22ebe0d45ffb5229fb73d78c5aae9.camel@oracle.com>

On Thu, Mar 07, 2024 at 08:13:50PM +0000, Allison Henderson wrote:
> On Wed, 2024-03-06 at 22:04 +0900, Yewon Choi wrote:
> > Hello,
> > 
> > It seems to be that clear_bit() in release_in_xmit() doesn't have
> > release semantic while it works as a bit lock in rds_send_xmit().
> > Since acquire/release_in_xmit() are used in rds_send_xmit() for the 
> > serialization between callers of rds_send_xmit(), they should imply 
> > acquire/release semantics like other locks.
> > 
> > Although smp_mb__after_atomic() is placed after clear_bit(), it
> > cannot
> > prevent that instructions before clear_bit() (in critical section)
> > are
> > reordered after clear_bit().
> > As a result, mutual exclusion may not be guaranteed in specific
> > HW architectures like Arm.
> > 
> > We tested that this locking implementation doesn't guarantee the
> > atomicity of
> > critical section in Arm server. Testing was done with Arm Neoverse N1
> > cores,
> > and the testing code was generated by litmus testing tool (klitmus7).
> > 
> > Initial condition:
> > 
> > l = x = y = r0 = r1 = 0
> > 
> > Thread 0:
> > 
> > if (test_and_set_bit(0, l) == 0) {
> >     WRITE_ONCE(*x, 1);
> >     WRITE_ONCE(*y, 1);
> >     clear_bit(0, l);
> >     smp_mb__after_atomic();
> > }
> > 
> > Thread 1:
> > 
> > if (test_and_set_bit(0, l) == 0) {
> >     r0 = READ_ONCE(*x);
> >     r1 = READ_ONCE(*y);
> >     clear_bit(0, l);
> >     smp_mb__after_atomic();
> > }
> > 
> > If the implementation is correct, the value of r0 and r1 should show
> > all-or-nothing behavior (both 0 or 1). However, below test result
> > shows 
> > that atomicity violation is very rare, but exists:
> > 
> > Histogram (4 states)
> > 9673811 :>1:r0=0; 1:r1=0;
> > 5647    :>1:r0=1; 1:r1=0; // Violate atomicity
> > 9605    :>1:r0=0; 1:r1=1; // Violate atomicity
> > 6310937 :>1:r0=1; 1:r1=1;
> > 
> > So, we suggest introducing release semantic using clear_bit_unlock()
> > instead of clear_bit():
> > 
> > diff --git a/net/rds/send.c b/net/rds/send.c
> > index 5e57a1581dc6..65b1bb06ca71 100644
> > --- a/net/rds/send.c
> > +++ b/net/rds/send.c
> > @@ -108,7 +108,7 @@ static int acquire_in_xmit(struct rds_conn_path
> > *cp)
> >  
> >  static void release_in_xmit(struct rds_conn_path *cp)
> >  {
> > -       clear_bit(RDS_IN_XMIT, &cp->cp_flags);
> > +       clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
> >         smp_mb__after_atomic();
> >         /*
> >          * We don't use wait_on_bit()/wake_up_bit() because our
> > waking is in a
> > 
> > Could you check this please? If needed, we will send a patch.
> 
> Hi Yewon,
> 
> Thank you for finding this.  I had a look at the code you had
> mentioned, and while I don't see any use cases of release_in_xmit()
> that might result in an out of order read, I do think that the proposed
> change is a good clean up.  If you choose to submit a patch, please
> remove the proceeding "smp_mb__after_atomic" line as well, as it would
> no longer be needed.  Also, please update acquire_in_xmit() to use the
> corresponding test_and_set_bit_lock() call.  Thank you!
>

Thank you for examining this and giving suggestions!
I sent a patch with changes including your suggestions. If it has
problems, I will correct them as soon as possible.

Sincerely,
Yewon Choi

> Allison
> 
> 
> > 
> > Best Regards,
> > Yewon Choi
> 

