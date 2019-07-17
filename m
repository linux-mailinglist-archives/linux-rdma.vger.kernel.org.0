Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05746BBF6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGQLzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 07:55:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32799 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQLzJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 07:55:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so17235767qkc.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H98SbFvDoh/ZsLjX/3wH4GmQSw3t4ma1NWM0ytiLkZA=;
        b=C8/Ib3O839qW/TZGyS1VdW/vO8zfbjPXJalPiDazk695/Uoyw3Na5FlDsE6RQAUT7L
         YvSRav3bL74vpROtLDjJV/lxchhRXVcg03NtKoesMTkLKZxirhN913P3A9sujC5pvWbm
         m5Tqo/2X2Q3NVyMgPRY2WbutzEXetlnrMQWoS2nuE8u5/ybu+jaBcIhdxx0a4Y8Jl6to
         KJxtqVXtTjZy5NocjPrmltrdIKPijLzttwQglzKOiCR6fEKZJwvMrjZIastmDm2Rw7rk
         7ehT2XI451tH9nRg8IVOy+WQGnNQ7pp4kSuTXmoqHfiZ2R03+aAi5H7xje+p04qyhv6v
         xnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H98SbFvDoh/ZsLjX/3wH4GmQSw3t4ma1NWM0ytiLkZA=;
        b=YVsaexfOnNaYr8u1H8hOY3GurRqO3CFn3g0nGiH4hXf2/bWFa9p10Uz8saklxFTpog
         QKxVQc1FkjaAUrws0mS9ukXP0lTvPZWDwrzmMbrOcPHEHHpZbW/lBVq0GvNW1pb1Wr5I
         sKXyLlHz4sgwkAUe7QeCN23ugZ/CYsAEuMIstmMRxvrVX9mzdnALv5YV/c0fBrfThA4d
         VtbvO7U1/0F9u2gX7A/6Uu45SZaV1ar04XSzmy79Dq1ZpZ5fFHcD+SMNMIzWyC60lOCf
         j2sm5lB+i1fE9A/SUzpao1zwN2+lU/xCpYKf9K+GK8bvIyLYEKRAC/MsNruB1RmMYIhM
         YTsg==
X-Gm-Message-State: APjAAAU+z/Cm5n1pIhaQ98eywT0FJr4uOgHA4pOHVt3trb9brJoes7tw
        WkFbQ5qiPnDuM/nQexp/V/d7TQ==
X-Google-Smtp-Source: APXvYqzG5Nu6QaINSq20xjJohAdLB6gx7B0BGJgAX45NVX5yib/QJcyLfkLigPtZmgHrWlDKZ9T28A==
X-Received: by 2002:ae9:f21a:: with SMTP id m26mr26626638qkg.430.1563364508627;
        Wed, 17 Jul 2019 04:55:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d20sm9874714qto.59.2019.07.17.04.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:55:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hniWZ-0003To-Ns; Wed, 17 Jul 2019 08:55:07 -0300
Date:   Wed, 17 Jul 2019 08:55:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/25] Shared PD and MR
Message-ID: <20190717115507.GD12119@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190717050931.GA18936@infradead.org>
 <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 02:09:50PM +0300, Shamir Rabinovitch wrote:
> On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > > Following patch-set introduce the shared object feature.
> > >
> > > A shared object feature allows one process to create HW objects (currently
> > > PD and MR) so that a second process can import.
> >
> > That sounds like a major complication, so you'd better also explain
> > the use case very well.
> 
> The main use case was that there is a server that has giant shared
> memory that is shared across many processes (lots of mtts).
> Each process needs the same memory registration (lots of mrs that
> register same memory).
> In such scenario, the HCA runs out of mtts.
> To solve this problem, an single memory registration is shared across
> all the process in that server saving hca mtts.

Well, why not just share the entire uverbs FD then? Once the PD is
shared all security is lost anyhow..

This is not the model that was explained to me last year

Jason
