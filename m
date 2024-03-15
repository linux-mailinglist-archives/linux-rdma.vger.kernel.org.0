Return-Path: <linux-rdma+bounces-1447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5787CAA2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BB6283C65
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8B17BC9;
	Fri, 15 Mar 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyO0hW97"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC5134B6;
	Fri, 15 Mar 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494705; cv=none; b=CH1FANW09IroyIsDFKkxDywu8ZPqQZWW7b00rnoC/bTUD0u7Qd9I6a8egTDKZIkIxTyTTSrpvyC3iAtWghoHU2OZC08I6XGtff98Og4JuCxyiZnqitDXFBALXzFuF9mz7Xa5nYZMV6ghZASo6g9PZcoDPFzplsgkmjzYV3gy6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494705; c=relaxed/simple;
	bh=/xuGS9yiiUhrBHkfhSrf4N48/8yyUswq89ZUt/7Z800=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+qvLzLPE8wP06KwdOmN4sl8jJbg011PB9dBDEuaFZpowIO/L8bjVGRKZQIx867HrSZ5VGX76eSGnmImOQU6OX4BiWU/fN++IMN4lUYZVSYrseG0V7ZTymjEHbMJTOz6K7avJN2OjAGSkCfhx+YObpmr0XXb5oiAZH//zmw69Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyO0hW97; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1401503a12.2;
        Fri, 15 Mar 2024 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494703; x=1711099503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLSa7ZOan89F/O1yeHJaOdFRWOViSYQvkogMEp0GklU=;
        b=JyO0hW97ppfZ2Q2GPxvr53AP8gzmGr4EThqrd0aSdbsB0o8iAL18gRcD9p4tAoKTnD
         oL6IlxVdjjM/EOpYHvqtvTD8aEoEjRzBNLCaUQmrH0jmSsY/CufAoKeygaILggWvdybQ
         ZMjYTyzONgrzmjH2NfbeUuKW106ADysRY9FHRx5RqeGHx5sxajg4KeQIAQz3+T7yohMt
         SFJUsjJzJ5k7S2itAp/wdop74gszcZ7J/xZenkdSDwwZFYprE71EbXcaSXUJETyOVMuJ
         ESU0yOfqYFz+OMGnuJcFaVo6zkOOO+WfHbNNcSOeChpY6XjFAbU/tpkKKRdo8bCCrevj
         jwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494703; x=1711099503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLSa7ZOan89F/O1yeHJaOdFRWOViSYQvkogMEp0GklU=;
        b=syyyvRplbqFIbT/awcnB3NmiQsUmtRwduQ4hxrrkeeB5EQzn2+oBgOaqmqZVbqYU5/
         qhZTTrBx9USJypNjIlk+5hKplScQXrXp7mao6hAEeMp+OVkvCwVlg4h6C5ze4p5XGd3V
         W+XGiseZqDXD/bWKVMNXOZXqIn+50Z8BKjvt4xAXncPt/ZWpXw1iBrPC6SMOgfZOgk51
         IXhsUM9J/awdbORKUwU8Kvm+K65iYRbMpvocsTx1u9FJY8c3tQv4xfhSXkHrBGWS7Ox5
         dX/CCvpwIZ95+PH46Aie2UI7I3MpRJwT0cCqi4MJkYEBURnLtSaE3nQrGx7Khu2J9HvS
         v8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3lZyMRVOfYO9aUcDXk8bXqDFcE2c+Pi4D7st+RW+XoIJOKLSJDngGswqwHArC4+MdZUWMab2GSH4zk8kbx1vcw/deQeqaCO5OMachEHTlg/8geWHfRZCSg1pxYvKCVRfhuDI/MkHrAY7OsL5FZShFZuOg5h5DnsbIDDtoF4m0Aw==
X-Gm-Message-State: AOJu0YwiPwO++BtujFHtXTG8Nw3vmr5+KjDZChjiXkiq676EQq6IPAKD
	As9PoE/WiHl5umYQ+vSeugJD6LmFXFSRm9y9CEjBpLFcdjmoYsGW
X-Google-Smtp-Source: AGHT+IFw9KIH8i2eDYKbcRUxqWmxqcfsJkaO5jItmX7XPiZNsORgPMEOZxdmKV3eETvyFS89d78fNg==
X-Received: by 2002:a05:6a20:43a0:b0:1a3:1574:5906 with SMTP id i32-20020a056a2043a000b001a315745906mr5216044pzl.15.1710494702697;
        Fri, 15 Mar 2024 02:25:02 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b001def765d26asm427233plh.8.2024.03.15.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:25:02 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:24:57 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
	"Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: [PATCH net] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Message-ID: <ZfQT6X7KOpbQtF9k@libra05>
References: <ZfLdv5DZvBg0wajJ@libra05>
 <ZfLkyiTssYD8wmVl@localhost.localdomain>
 <4997357157f5735d07efdc7cd45388bd32375e5c.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4997357157f5735d07efdc7cd45388bd32375e5c.camel@oracle.com>

On Thu, Mar 14, 2024 at 10:37:29PM +0000, Allison Henderson wrote:
> On Thu, 2024-03-14 at 12:51 +0100, Michal Kubiak wrote:
> > On Thu, Mar 14, 2024 at 08:21:35PM +0900, Yewon Choi wrote:
> > > acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so
> > > they
> > > are expected to ensure acquire/release memory ordering semantics.
> > > However, test_and_set_bit/clear_bit() don't imply such semantics,
> > > on
> > > top of this, following smp_mb__after_atomic() does not guarantee
> > > release
> > > ordering (memory barrier actually should be placed before
> > > clear_bit()).
> > > 
> > > Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.
> > > 
> > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > 
> > Missing "Fixes" tag for the patch addressed to the "net" tree.
> >

Sorry for mistake, I'll correct this and send v2 patch.

> > Thanks,
> > Michal
> 
> Yes, I think it needs:
> 
> Fixes: 1f9ecd7eacfd ("RDS: Pass rds_conn_path to rds_send_xmit()")
>
> Since that is the last patch to modify the affected code.  Other than
> that I think the patch looks good.  With the tag fixed, you can add my
> rvb:
> 

Also, test_and_set_bit/clear_bit() was first introduced in
commit 0f4b1c7e89e6. I think this can be added, too:

Fixes: 0f4b1c7e89e6 ("rds: fix rds_send_xmit() serialization")

> Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> > 
> 

Thank you for the reviewing.

Sincerely,
Yewon Choi

