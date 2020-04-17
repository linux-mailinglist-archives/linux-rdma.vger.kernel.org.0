Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECD1ADEBA
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgDQNuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730759AbgDQNuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 09:50:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4FC061A10
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 06:50:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j4so2351560qkc.11
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0zcNvdKdai5+wZ9tPiIjxeHl1r1POZ3pfY1yVYty/CE=;
        b=O8CXYfnFgyT3JxRsc7Le4trNF7KXYW5D1b+IqKzvIlluMnBQxEUoMH8H40fIbIC0P3
         65maZjgung61OOmf3WIxLWtlswk2NRhvgoBny0laR0PNDlDxgoBs3SM1df/AA1hEPz4I
         uIfcx0OtTyRzIRunc/iOMdHvQ/kJE4ov7v6992OWPGYatRHl3uDfOF2VImJndJ2IP4CS
         hX/oVWRmX2FqvdyronHkVG2xshVc4r9eduWZKxWPneggQzI3Sz/AWvagvUiXoIMq8PjA
         d7zbvjrevHDJZ1TAhI+ui9e6uXcJrhndRrYyvtKMM1vS88nmuWheKmNpaKchUdegcaNB
         5ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0zcNvdKdai5+wZ9tPiIjxeHl1r1POZ3pfY1yVYty/CE=;
        b=JEZNGy1ebk5t7HYb/zwfttCytjbxj2IrzekaHd5/cWtK75tvj32qUHV84TlZPBlxuR
         wfJmCxIr1fuSUVkbPgdE7O2b3tQHsyTflhRuDQXcNIrpSDFc45mvd+vFB6fx4+mkbdWj
         bpqc5yX0nbC5dpOvRDKujrhd6mr6Vt7zYecHFIJXwcYMeDxxmiT+jBnM2JKIL6UOOuBX
         TNIkTVWUbyXVmj/MNbj1UlCNU+1Oh5nqX8QQThWE6W3vPnLIL1qmyx58puYZ7hIC9IF7
         DcriaKA86MW1HrqeTDEyEVlLw857FfnN6kKhFvoSTVBuX0bmorLf4o23gskp9kNKgWPJ
         wTbQ==
X-Gm-Message-State: AGi0Pubq7N+nkfiqLcRCrl0sNFGieZKRmYCDgzCw0ML/0lFcU9+a0SsB
        OVSM6oN6f+q0m9LA5JGM04jGrw==
X-Google-Smtp-Source: APiQypJUph/pZ7+qqCeSnYdiVZYUfGc29i+OGh5I254nq16GQjpEH/+/7PYVLPTMZgZGL+VfYOxhCQ==
X-Received: by 2002:a37:5a02:: with SMTP id o2mr3256734qkb.380.1587131402855;
        Fri, 17 Apr 2020 06:50:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g6sm5127171qtc.52.2020.04.17.06.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 06:50:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPRNZ-00005H-RZ; Fri, 17 Apr 2020 10:50:01 -0300
Date:   Fri, 17 Apr 2020 10:50:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417135001.GE26002@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <8c17ed4f-fb29-4ff8-35db-afab284c6e71@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c17ed4f-fb29-4ff8-35db-afab284c6e71@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 03:28:21PM +0200, Marion & Christophe JAILLET wrote:
> 
> Le 14/04/2020 à 20:34, Jason Gunthorpe a écrit :
> > On Sat, Mar 28, 2020 at 08:30:40AM +0100, Christophe JAILLET wrote:
> > > There is an off-by-one issue when checking if there is enough space in the
> > > output buffer, because we must keep some place for a final '\0'.
> > > 
> > > While at it:
> > >     - Use 'scnprintf' instead of 'snprintf' in order to avoid a superfluous
> > >      'strlen'
> > >     - avoid some useless initializations
> > >     - avoida hard coded buffer size that can be computed at built time.
> > > 
> > > Fixes: a51f06e1679e ("RDMA/ocrdma: Query controller information")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > The '\0' comes from memset(..., 0, ...) in all callers.
> > > This could be also avoided if needed.
> > >   drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 9 ++++-----
> > >   1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
> > > index 5f831e3bdbad..614a449e6b87 100644
> > > +++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
> > > @@ -49,13 +49,12 @@ static struct dentry *ocrdma_dbgfs_dir;
> > >   static int ocrdma_add_stat(char *start, char *pcur,
> > >   				char *name, u64 count)
> > >   {
> > > -	char buff[128] = {0};
> > > -	int cpy_len = 0;
> > > +	char buff[128];
> > > +	int cpy_len;
> > > -	snprintf(buff, 128, "%s: %llu\n", name, count);
> > > -	cpy_len = strlen(buff);
> > > +	cpy_len = scnprintf(buff, sizeof(buff), "%s: %llu\n", name, count);
> > > -	if (pcur + cpy_len > start + OCRDMA_MAX_DBGFS_MEM) {
> > > +	if (pcur + cpy_len >= start + OCRDMA_MAX_DBGFS_MEM) {
> > >   		pr_err("%s: No space in stats buff\n", __func__);
> > >   		return 0;
> > >   	}
> > The memcpy is still kind of silly right? What about this:
> > 
> > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > {
> > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > 	int cpy_len;
> > 
> > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > 	if (cpy_len >= len || cpy_len < 0) {
> > 		pr_err("%s: No space in stats buff\n", __func__);
> > 		return 0;
> > 	}
> > 	return cpy_len;
> > }
> > 
> > Jason
> 
> It can looks useless, but I think that the goal was to make sure that we
> would not display truncated data. Each line is either complete or absent.

So it needsa *pcur = 0 in the error path?

Jason
