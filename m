Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEA1DBA70
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETRB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 13:01:59 -0400
Received: from fieldses.org ([173.255.197.46]:47300 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETRB7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 13:01:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D82AF1D3E; Wed, 20 May 2020 13:01:57 -0400 (EDT)
Date:   Wed, 20 May 2020 13:01:57 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
Message-ID: <20200520170157.GB19305@fieldses.org>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
 <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
 <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
 <20200520164639.GA19305@fieldses.org>
 <C607718F-3690-4147-B993-EC964FDCE4B9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C607718F-3690-4147-B993-EC964FDCE4B9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 12:48:15PM -0400, Chuck Lever wrote:
> > On May 20, 2020, at 12:46 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > --- a/README
> > +++ b/README
> > @@ -18,6 +18,10 @@ For more details about 4.0 and 4.1 testing, see nfs4.0/README and
> > nfs4.1/README, respectively.  For information about automatic code
> > generation from an XDR file, see xdr/README.
> > 
> > +Note that any server under test must permit connections from high port
> > +numbers.  (In the case of the NFS server, you can do this by adding
> > +"insecure" to the export options.)
> 
> Thanks! One nit:
> 
> "In the case of the Linux NFS server"

Whoops, fixed.  Thanks.--b.
