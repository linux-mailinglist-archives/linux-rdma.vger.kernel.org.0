Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9418B8AC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSOIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 10:08:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43463 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCSOIu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 10:08:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so3140661wrj.10
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99K2Gw3OyNC688bY0UbsB4VsbokKiE/LOqor4VmBdao=;
        b=NzNbbUsPHbl3jpzp+5eJSeEd92Hj76Z9w0lKlIO6KF3ap/PviXDMp+1zcCAJpuFDWF
         33y0qfJutWvtLXKQgG2y/m20jqhIat0vAXXtJ5uvFpaohYkeZUFkNOtB9oi5aNzjFp9h
         f9kU7z6171wUTxX4R3fmFGy6KYGmo8yzZwgFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99K2Gw3OyNC688bY0UbsB4VsbokKiE/LOqor4VmBdao=;
        b=J81tEr286hGi+cSTjNanlIhEY5SvrLyYl4+lKd1Uba7Sq6TSgJ2aDnL3r4zEuP7lmE
         /YO5Q0ZKCXQyLMNqmw4jU8TGaPsnrvXB4/w2R+4SWUCuDVJwv+RdmSA8kw00GToVn/7F
         Y3m3KAlYwh+BvXjlv19uH5S/hFMYj4jYzVJaNQK49exGBFk8YcLWxQsE7tsc1azKYy0p
         139fEsqXsbWf1taoXU4v1UFTv7Q3O8OhD39Tihb0xsxknw5DUEfgxlhbm2XZfedb8bzs
         kindJqmFo3TP58K2ncaeWw8GcFMcx3FHaNn8YUut8GCIuKm2B2qEoBxGo0RzLj7Wp7nn
         Y0HA==
X-Gm-Message-State: ANhLgQ0BHDWrxPbYKSnZTOJQKNVGEd/WvwRUtaL4RnVPgxG3usobmTbN
        +2EHtTtYy2JGm8lkDE8PlPuJGGysqGjl5HyqvUQ=
X-Google-Smtp-Source: ADFU+vubzEV76oU1jJKRuuzpLgfRjDsA9/unbxRRyZDLkthpW3WE2Ye4dY/IF7WdPlNRrP35EEsr7Q==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr4474483wrn.400.1584626928770;
        Thu, 19 Mar 2020 07:08:48 -0700 (PDT)
Received: from chatter.i7.local ([45.67.14.0])
        by smtp.gmail.com with ESMTPSA id j39sm3880051wre.11.2020.03.19.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:08:46 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:08:39 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, loberman@redhat.com,
        bvanassche@acm.org, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        rgirase@redhat.com
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Message-ID: <20200319140839.7a2opbgqpenlrtlj@chatter.i7.local>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
 <20200319115431.GU13183@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319115431.GU13183@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 08:54:31AM -0300, Jason Gunthorpe wrote:
> > > Max, how are you sending these emails, and why don't they thread
> > > properly on patchworks:
> > > 
> > > https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
> > > 
> > > This patch is missing from the series
> > > 
> > > v1 had the same issue
> > > 
> > > Very strange. Can you fix it?
> > 
> > I'm using "git send-email".
> > 
> > Should I use some special flags or CC another email for it ?
> > 
> > How do you suggest sending patches so we'll see it on patchworks ?
> 
> I looked at these mails and they seem properly threaded/etc.
> 
> I've added Konstantin, perhaps he knows why patchworks is acting
> weird here?

Not sure. Everything appears to be properly threaded. I see 2/5 arriving 
at precisely the same time as the cover letter, so 2/5 probably got 
processed before 0/5. I have no idea if that actually matters to 
patchwork -- a whole bunch of series would break if arrival ordering was 
that important. At least I assume that would be the case.

I'll check with upstream.

-K
