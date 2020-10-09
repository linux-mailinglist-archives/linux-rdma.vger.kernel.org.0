Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD1288BA4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgJIOjn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbgJIOjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:39:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83CC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 07:39:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t20so4853661qvv.8
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rt4wAfb5l6FEnURF1tsFZ7sJF1s13ttCQMfCF91s3T0=;
        b=SdutQQJqmy/P77+ew1Qu7peuN6sXbl8dp18K3TQjszIEXKsymcbhY7X9/q+WPHdFCt
         idbNegem8qXi+ZFy4NknLNhrY0qwtebsfuxE6derNgik38l8C4hfMYlHLqEtjqpXiMhD
         6uimrjK9gO2sthg9c087Rhm30+piKmPEvq6a7IIDa1+UnbKtwRkib1+xsebHiy866zyi
         jpa4aqzO6jlaO2ziiehlzmye6vbRpaKV8crBtBLWxYbxlQipo0JIcd4J2S3Xynqw/Zid
         SHYIVWssmgb9JuH+dMF/MxJBlQmzFoYjGvy2pgpwKA7qkodhaM+2/wqaIFD76IIJTpmv
         jX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rt4wAfb5l6FEnURF1tsFZ7sJF1s13ttCQMfCF91s3T0=;
        b=mHcS68q4D0S6y4Lvqg1I9LkruopemaXUNGHAKkYNTOXKrutvq4ZW5xEFTbv/sNi4zN
         bymRs9vcpgpRrAvenP3tnZyy4775KODbvnKtEMsaIsTkjLxVPTWfumFPyubY5YPdmqq+
         n5vFondCaYpbI1b8+QFEaNHRh/7jdg4U329NSvU5EjFS9DBiZcqDkKZP1af2xtgOHVEL
         R+cpCDQrjPgohUU3mIjfXNox8b6gPoYzGj/X2MGxKEyVi51ztHlmjjOUNYQoG2ydZoKT
         ScqIr5SP9KOaacnZti4rNhYoA3OJgGGL3kBL2mdxnkYg8tHv6Mru8uZv3m9m5dlC4rja
         m99Q==
X-Gm-Message-State: AOAM533OOoUUJGrwoy6VBTyfIXewWhW54ln8rP1Ajl6nVVXGDDMVPh8U
        hg1PMhOIdS2wBU9ca93LYMZXIQ==
X-Google-Smtp-Source: ABdhPJwttOIme768baG4gb2/SHMB5njcdNK3FoZ6OB9PxcQR1o2SEU4EMMBD9a10XgbUeIWC+9to/Q==
X-Received: by 2002:a0c:c548:: with SMTP id y8mr6529252qvi.41.1602254381608;
        Fri, 09 Oct 2020 07:39:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 15sm6232076qka.96.2020.10.09.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:39:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQtYa-00200d-FU; Fri, 09 Oct 2020 11:39:40 -0300
Date:   Fri, 9 Oct 2020 11:39:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201009143940.GT5177@ziepe.ca>
References: <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
> As I mentioned before, this is a very serious restriction on how
> the RDMA subsystem can be used in a namespace environment by kernel
> module.  The reason given for this restriction is that any kernel
> socket without a corresponding user space file descriptor is "rogue".
> All Internet protocol code create a kernel socket without user
> interaction.  Are they all "rogue"?

You should work with Chuck to make NFS use namespaces properly and
then you can propose what changes might be needed with a proper
justification.

The rules for lifetime on IB clients are tricky, and the interaction
with namespaces makes it all a lot more murky.

Jason
