Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799C51A88F5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503710AbgDNSP3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 14:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503671AbgDNSP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 14:15:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2AC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 11:15:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x2so11037792qtr.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=agu9gYi+uPzLleFUhDwB5wW6cVMEnsfdNyOOKY7nzfI=;
        b=ZApa+iscNPzQkc8mcc5SQ0VCp3h93gNI8A/eGraZ4KivSTPuL1dkdLkyNUDns68E/2
         h+FR0rfBvtGXuvv/JT5JVdI+kQ23+yjrxzfNsauqd5MpCTHQjLanEYLZ02iFHHWM3eHt
         D62w5LLZCZ/wwF4miZVgN97Xs+uMwt4OqW/u9CXC/s+vw5Ei8Q7TdTeVFQssLQBHTlq6
         BTNzSw3Kt6aIu9uz7DyJsxub1Rwb7ivgcBUcRz6KeBj98+nSAsdepjMPAZYsCsvwzURb
         FDlpSo4PoexU97HnWTlkXK2Z+bCpui3mO5oY9inwRHmyR3dHxahevlvouTpFtCo8PZTa
         DuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=agu9gYi+uPzLleFUhDwB5wW6cVMEnsfdNyOOKY7nzfI=;
        b=fBckrY/md5GP2h0D2RP6WrE5MTwNXrG7svDRLW4Bcmf/X0l05oRUsmAwZIrzF1+VPV
         k/t4d8hKtg4jdmcGSAZST9dybVWPhoSVnV1ITykJB7L8EfOChaTEag9wpmj16MGqBw8F
         100a4CeMyM7EExAprjZq4SNYs9HnDuNuOmKSx6BFg2N+QRJ/Yyk2H9C6xYkJLEU8g1v5
         1jmjPGUmrzEch3MNvh8zBP4kPO+nTb4fAkQ8/JjlmJNErAh5Khpe1zHyjiHDALLEPDFR
         fRgM/XggSu9x5rc4Uqf4++8kIg8coyzH1r6KcigjU+2BJTQsyVsUMOh5wNI/Q1PWOW7D
         f2OA==
X-Gm-Message-State: AGi0Pub44krQMK9X8hJwI/pLdZWOFl69EQACxpSsjypa+s8SmRpEjUrE
        /0TtIJziWCKEh0+fMyma0nt7kw==
X-Google-Smtp-Source: APiQypID6qWlx8oVOFhlfTNbfMpS9xdMjbcQbNuq5BhfCjDVo2+eAjLQXR4vlu0A7unMQDVfZpe4Zg==
X-Received: by 2002:ac8:4809:: with SMTP id g9mr5852932qtq.33.1586888125906;
        Tue, 14 Apr 2020 11:15:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x16sm10174191qts.0.2020.04.14.11.15.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 11:15:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQ5k-0007oo-Pt; Tue, 14 Apr 2020 15:15:24 -0300
Date:   Tue, 14 Apr 2020 15:15:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414181524.GI5100@ziepe.ca>
References: <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
 <20200414151303.GA9796@fieldses.org>
 <20200414152016.GE5100@ziepe.ca>
 <20200414161744.GB9796@fieldses.org>
 <20200414181141.GA1239315@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414181141.GA1239315@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 09:11:41PM +0300, Leon Romanovsky wrote:
> On Tue, Apr 14, 2020 at 12:17:44PM -0400, J. Bruce Fields wrote:
> > On Tue, Apr 14, 2020 at 12:20:16PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 14, 2020 at 11:13:03AM -0400, J. Bruce Fields wrote:
> > > > On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > > > > > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > > > > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > > > > > The commit ID is what automation should key off of. The short
> > > > > > > > description is only for human consumption.
> > > > > > >
> > > > > > > Right, so if the actual commit message isn't included so humans can
> > > > > > > read it then what was the point of including anything?
> > > > > >
> > > > > > Personally as a human reading commits in a terminal window I prefer the
> > > > > > abbreviated form.
> > > > >
> > > > > Frankly, I think they are useless, picking one of yours at random:
> > > > >
> > > > >     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> > > > >
> > > > > And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
> > > >
> > > > Ow, apologies.  Looks like I rebased after writing that Fixes tag.
> > > >
> > > > I wonder if it's possible to make git warn....
> > > >
> > > > Looks like a pre-rebase hook could check the branch being rebased for
> > > > "Fixes:" lines referencing commits on the rebased branch.
> > >
> > > I have some silly stuff to check patches before pushing them and it
> > > includes checking the fixes lines because they are very often
> > > wrong, both with wrong commit IDs and wrong subjects!
> >
> > I'd be interested in seeing it.
> 
> checkpatch.pl checks it or supposed to check.

This doesn't do the --is-ancestor check, so it is quite weak. It would
not have triggered for Chuck because he'd still have the commit in his
local git from the rebase.

Jason
