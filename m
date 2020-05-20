Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51961DA636
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 02:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgETAKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETAKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 20:10:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D34C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:10:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb16so547531qvb.5
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1nnNMMnWgVyddSvx9CTHRp85r+Uj2T/EgMi8iim52iY=;
        b=LVb/LnYEoZe/hqO2/o5y+SCwpWFlcD/OzI++bhVo7RKZq90uUz9gmoGH+/45X+MDte
         9Itf5OW4Cc0+8iNIsEp9QldXccLCYOOXxe57Sm1cHCDdjlfkgY+6MWzPqdPE0N5W6sVJ
         UngYpYZ+SFTMFjtCSYMyEMMwIJffklZXje5JNDyn8tYKYQ9YG5zlcqBdqHOfU0oQ9Uw9
         sXxDcISZGRbopbiyyH/7otZAIWj0g9hDoVNxGs8EVQgDkvbjYdF0GJMDl1atusMM+kci
         maK30q1hgpUahvg+JY+rRdll417il1WAMpgiGnih61Jo9t2HhRiV5twbf75SYKTXX2NG
         LrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1nnNMMnWgVyddSvx9CTHRp85r+Uj2T/EgMi8iim52iY=;
        b=LyNQBZt3z+WwNWjeYzNl1ffG2qm/V0TstuBDZc1ewJNUq0NLmAPGD5ig0LtxRGMpvF
         ik3y2U1Ckt/Gez6ord9h+uMpAY6e/nNFeSwRHR/szS8EpgWJpc77GwdcLhhOG5ccfkyB
         1stMEdmW9OezHZkt3B0mSoY18m/I+KlHoRrgKDnKB6oYK9HiUg5XP8lJQI3CfxEEM4Y7
         9cqHw0r2x/GYurXrhVsfPm2rg+HhwbwBckVrLNR5xX5RXxZyNuaQaa2+OcF7K4gE9JWJ
         aZLpzXwaLMHqbOXHV3H7VUSo7zZU7tF6t6J4ILQOGNZCUaWrcmUjWnye92aIQGDoiaw5
         ODNQ==
X-Gm-Message-State: AOAM531Rk4WCs0VYn+Ul9fQ4My3IT8dl46SAv4BAgB1lSAh9AJmFapTg
        pZf7gXdGthcboLJXuCCwVelZKg==
X-Google-Smtp-Source: ABdhPJwsz5AKr0aQtHN738xGZhJMASG0JaA7L/CXolhH1cBCNFuWAt77YF/YQI1M6dbZTVO5OtyTrQ==
X-Received: by 2002:a05:6214:42f:: with SMTP id a15mr2302980qvy.170.1589933446165;
        Tue, 19 May 2020 17:10:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d196sm959328qkg.16.2020.05.19.17.10.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:10:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCJp-0003It-Am; Tue, 19 May 2020 21:10:45 -0300
Date:   Tue, 19 May 2020 21:10:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Message-ID: <20200520001045.GA31189@ziepe.ca>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <20200508000809.GM26002@ziepe.ca>
 <33fc99e2-e9fc-3c8c-e47f-41535f514c2d@oracle.com>
 <20200513150021.GD29989@ziepe.ca>
 <c761da30-3663-4932-dd72-3501f15c0197@oracle.com>
 <272dbe83-a72b-d38b-6993-d3bbda50a7d1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272dbe83-a72b-d38b-6993-d3bbda50a7d1@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 04:30:52PM -0700, Divya Indi wrote:
> Hi Jason,
> 
> I wanted to follow up to see if you got a chance to review the following reply?

Not yet, it still seems bad to be doing code like this.

If two threads are sharing memory they really need to use a
refcount/kref not rely on some sketchy thing with flags. It is very
hard to tell if the sketchy thing with flags is correct or not.

Jason
