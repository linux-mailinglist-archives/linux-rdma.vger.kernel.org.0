Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD917D230
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2020 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCHHTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Mar 2020 03:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgCHHTC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Mar 2020 03:19:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6AD20663;
        Sun,  8 Mar 2020 07:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583651941;
        bh=6+XCWxlY5sjTK2a1K2zLcBwlHeTbz89s8X3whvgV6c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbjoYJeBS5u+rMTuoX1JaXg/tYfTEHrvVbVPwNY8nV2zIycIEVXEagCG50BEzwW0o
         b0ZA0U8wTdHf1vTB4VmfXwVe0LTklnEdUI2chXMv7qFAIe5oDT52smtf8PyYt47tsG
         +befL0xPdG26W00rLwtggM+jKfi83gNDEUavzKmk=
Date:   Sun, 8 Mar 2020 09:18:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 2/9] RDMA: Promote field_avail() macro to be
 general code
Message-ID: <20200308071858.GR184088@unreal>
References: <20200305150105.207959-1-leon@kernel.org>
 <20200305150105.207959-3-leon@kernel.org>
 <20200305151850.GZ26318@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305151850.GZ26318@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 11:18:50AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2020 at 05:00:58PM +0200, Leon Romanovsky wrote:
> >
> > +/**
> > + * FIELD_SIZEOF - get the size of a struct's field
> > + * @t: the target struct
> > + * @f: the target struct's field
> > + * Return: the size of @f in the struct definition without having a
> > + * declared instance of @t.
> > + */
> > +#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
>
> This is already sizeof_field

Ohh, thanks

>
> > +/**
> > + * field_avail - check if specific field exists in provided data
> > + * @x: the source data, usually struct received from the user
> > + * @fld: field name
> > + * @sz: size of the data
> > + */
> > +#define field_avail(x, fld, sz) \
> > +	(offsetof(typeof(x), fld) + FIELD_SIZEOF(typeof(x), fld) <= (sz))
>
> This is just offsetofend, I'm not sure there is such a reason to even
> have this field_avail macro really..

Even better.

Thanks

>
> Jason
