Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA71508F3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBCPBB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 10:01:01 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38028 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCPBB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 10:01:01 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so12871451ilq.5
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 07:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjtdGuJ68ZZWGhduxwgKWErxiz/0ie0xdiGkLM375wQ=;
        b=N4LKAfL6IC4InG8qiZk+Ol4o/sD3hWVYRPbGSoN6Cvh88gdzUcvXF37kPU94/MOmX7
         NZGWAEWiCplNiBDv21tOIJBVBm9Lr+IC4MvrybEAvAGHToXqkGn7nKfFDOUS2SFPX2VD
         VT0xCUllQ0pMmOlla0qS1aYve5VxlZ7IiTARY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjtdGuJ68ZZWGhduxwgKWErxiz/0ie0xdiGkLM375wQ=;
        b=PEWhpcGTtk9xhcKG5CvaRcNMRtbO4uu7pKcoYzmB+efQI6LUsOC36B8GU7AqgJZCBy
         +PMGOYTohyEHErnz+rzQoG5+Vo4xoIakUgEYqZh+PqnWseIntDcz2pJegHmQ8eLcJecK
         MSnqIyHMJx1ef6KKYb7RAL7kXFQpAFR4Jmo8MSZ9odT8/thnL3Pq6n7q5QDd0ykSl3UM
         LDGrMSyuXt8hoIgjI2cwJOsAZXywnSI5bu/dKKwzPVoCYRyZUxk+M7GoQNS33/UNsNPD
         0DbmI7Qrdl6sqytRRruiQmtxeqRJJWQMheYg5QZQXXUitLUql/BPvhriXYBMvaxXNSNG
         am9w==
X-Gm-Message-State: APjAAAUgOJLlmc6WtOklg6ASO9g4EXFqixXvXiwlWs3heNNQVc7TOI5N
        M/OXK2qFKu1LXBXJ7S14/OGZhNkhbrLAWSjJKUhMPA==
X-Google-Smtp-Source: APXvYqyfUtevTKX6b94u2mFyjB35riqC6bj2TQqjuaSahUJQx+TRabdXR9RzGEtmXa6O5SziKixvaMJrb09JuFd/ShA=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr15108710ilg.285.1580742060747;
 Mon, 03 Feb 2020 07:01:00 -0800 (PST)
MIME-Version: 1.0
References: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com> <65ab8a55-2155-cf1e-fcd8-b87fc7360a36@amazon.com>
In-Reply-To: <65ab8a55-2155-cf1e-fcd8-b87fc7360a36@amazon.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 20:30:23 +0530
Message-ID: <CANjDDBi=2GXy6VNrHmT_4f1-8MeihGsA5EQXrxn2kkqkwGrMiA@mail.gmail.com>
Subject: Re: [PATCH v3] rdma-core/libibverbs: display gid type in ibv_devinfo
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 2:43 PM Gal Pressman <galpress@amazon.com> wrote:
>
> On 03/02/2020 7:47, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> > index bf53eac..bbaed8c 100644
> > --- a/libibverbs/examples/devinfo.c
> > +++ b/libibverbs/examples/devinfo.c
> > @@ -162,8 +162,18 @@ static const char *vl_str(uint8_t vl_num)
> >       }
> >  }
> >
> > +static const char *gid_type_str(enum ibv_gid_type type)
> > +{
> > +     switch (type) {
> > +     case 0: return "IB/RoCE v1";
> > +     case 1: return "RoCE v2";
> > +     default: return "invalid value";
> > +     }
> > +}
>
> Why hard code the enum values? Use IBV_GID_TYPE_IB_ROCE_V1 and IBV_GID_TYPE_ROCE_V2.
Agree, changing it.
