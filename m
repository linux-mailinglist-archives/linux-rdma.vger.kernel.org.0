Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4214E755
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 04:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgAaDEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 22:04:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727739AbgAaDEn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 22:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580439882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSJxv3xcJ5JP5Fb5zacyAEC1KTHhk6oABLjFOY/Cda4=;
        b=N3VC1VYy3wfqBxBLrAy5KhaBP6WGCEjLcW/TUaMJRnf7oxPiI4YPTep3TcECg21cKcQkT6
        XJi80Qvc+tLVxbdmPJKa5VHaJbdvEEBQI3s6Lyisx0s3Rw8oftkqmRKAA/JCG0iwR03LNp
        ZVTX1CifdcFp4m5D1XWRPcewtReMhJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-f75v9Zt3PCGp7oJVOkzvPg-1; Thu, 30 Jan 2020 22:04:38 -0500
X-MC-Unique: f75v9Zt3PCGp7oJVOkzvPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921D2800E21;
        Fri, 31 Jan 2020 03:04:37 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F27075D9E5;
        Fri, 31 Jan 2020 03:04:36 +0000 (UTC)
Date:   Fri, 31 Jan 2020 11:04:34 +0800
From:   Honggang LI <honli@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Hefty, Sean" <sean.hefty@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: resource leak in librdmacm
Message-ID: <20200131030434.GB359069@dhcp-128-72.nay.redhat.com>
References: <20200121122133.GA105701@dhcp-128-72.nay.redhat.com>
 <BYAPR11MB3272F4913688AE9B3BFF815C9E0D0@BYAPR11MB3272.namprd11.prod.outlook.com>
 <20200122085655.GA126224@dhcp-128-72.nay.redhat.com>
 <20200122152258.GA142196@dhcp-128-72.nay.redhat.com>
 <20200123142135.GA171304@dhcp-128-72.nay.redhat.com>
 <20200129010449.GA29820@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129010449.GA29820@ziepe.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 28, 2020 at 09:04:49PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2020 at 10:21:35PM +0800, Honggang LI wrote:
> > On Wed, Jan 22, 2020 at 11:23:02PM +0800, Honggang LI wrote:
> > 
> > > void test_fini(void)
> > > {
> > 
> > 
> > > 	if (handle)
> > > 		dlclose(handle);
> >                 ^^^^^^^
> > > 	handle = NULL;
> > 
> > In case we did not call dlclose, there will be only one file descriptor
> > leak. It will reduce the file descriptor leak.
> > 
> > Does that imply librdamcm was designed to load once and only unload when
> > process exit?
> 
> Yes.
> 
> We had some old code that attempted to clean up on dlclose/process
> exit, but it turns out that whole concept is racey and broken when
> threads are used.
> 
> To run valgrind testing like this the library needs to provide some
> kind of 'cleanup internal data' call, which our libries don't have. 
> 
> I think it would be useful addition to both libraries.
> 
> You should also see memleaks from valgrind on exit, IIRC. Lots of
> static lists don't get cleaned.

Thanks for the explanation!

