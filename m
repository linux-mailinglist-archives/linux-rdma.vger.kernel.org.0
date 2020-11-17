Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7282B6EB4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKQTdc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 14:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgKQTdc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 14:33:32 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED0C0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 11:33:32 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id q7so11301363qvt.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5aCgCWj3poVg2jFDgfbkWAbsDOsSNcE+785dZ4ojIoc=;
        b=SvR2DroSYb8TZZPv1z1ETYgHoxuWhWYgAy79HDRimZFjviFWQC4ARgIT4hQCACogzv
         7n01rNi0AZHjpZ+5xmExtM1oKiiXoXkVOvEA53fhwForpOyryoI2WYplvE3eo3JdxnBO
         yEV4Eyg3hPXnMLDepTGzdeHewO+92Ayt7sSfEwOquBO9nWZp4ezxC2wjvnHwgGNjPRy8
         Uzgp5+E6WAEHgm+kYWrO8szMBQwnF6lSDicCx/8d+O1v/yQN6fh1O2hr6JgdiGwr60yy
         IZIjitWn3tmsDoQkXuW9iwSbxg4Q7y29IhLdDVqPo9hq9UNpOxyTshJfnr1dCXpuggcq
         jaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5aCgCWj3poVg2jFDgfbkWAbsDOsSNcE+785dZ4ojIoc=;
        b=OxprjUzn1dNWwYEkLYzYwEUN5LDm5QRNqhpT9QbMlXx06fl28wS4KWSkB+luafKvfH
         BEZHDuxR/eqPQUJyBD+x+5UZ5JFpyDP0QeKY+gpheWvpB1pUPduPcF6QGkjxmyNWYOcD
         xlncGlRapzWVSqoXdm4VkPtBp2dPPE9c2kGgoaqqiOpo6ZXqn7ieYHVTo5/u9lH/PCmy
         Rzr7HB8UNmDz1KKTyM+iOn3+CUxLhU+cK8xHKo6YuNRxKbhkaXrOX4Xab57S/noodQy9
         kDAB1nOwRm4A/mhMNzr99PBiFn5OP6DEJfl/QWl58uMAHMYpP50WWrCU0LAne8S1sPZx
         k0Rw==
X-Gm-Message-State: AOAM533Bsi/SbQpS3F6IiB1ATcqh9fYW/83QJVWQfYaVXQWQ0BV9bV1/
        wqtZMkTkjnFHulkzfGaxurGOcgz2QG78NKFE
X-Google-Smtp-Source: ABdhPJwgil9wAPk44FvWtRYyliwL4Ic1AzwOmN0rH7Gw59lOazPw9vjtzjXTvSS0TGmRnp1cYvf5eA==
X-Received: by 2002:ad4:50a2:: with SMTP id d2mr822749qvq.21.1605641611307;
        Tue, 17 Nov 2020 11:33:31 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f130sm13741938qke.30.2020.11.17.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:33:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kf6jJ-007MEG-3r; Tue, 17 Nov 2020 15:33:29 -0400
Date:   Tue, 17 Nov 2020 15:33:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christopher Lameter <cl@linux.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Mark Haywood <mark.haywood@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
Message-ID: <20201117193329.GH244516@ziepe.ca>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 02:57:57AM +0000, Christopher Lameter wrote:
> We have a large number of apps running on the same host that are all
> sending to the same set of hosts. Lots of requests for address resolution
> are going to the SM and for a large set of hosts this can become too much
> for the SM.
> 
> Is there something that can locally cache the results of the SM queries to
> avoid additional requests?
> 
> We have tried IBACM but the address resolution does not work on it. It is
> unable to complete a request for any address resolution and leaves kernel
> threads that never terminate instead.

If it really doesn't work at all any more we should delete it from
rdma-core if nobody is interested to fix it.

Haakon and Mark had stepped up to maintain it a while ago because they
were using it internally, so I'm surprised to hear it is broken.

Jason
