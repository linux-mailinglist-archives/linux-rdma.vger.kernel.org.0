Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3642459C1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHPWEq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Aug 2020 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHPWEp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Aug 2020 18:04:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3673DC061786
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:04:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so11773635wmj.5
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EK59YeNweTnOCzZsjEDake2xeFN5dYABW/jYJ1/liXs=;
        b=YA0oAo1VWal5Tb3eEe7QXmMHEp6z2k+gGz7Kw/Adk3aiiU4zD63T7k9z3xSyqIEoKj
         cXPtMIJnCTw34wlhboByQkBaMD1xhJ+3t+l+y0PIN/+pUenvRE34hsco4JWWnBqCTaM9
         MfG+yEnxHghtz73BxDvXQD7oj9zG+ekrcsodWFuIXvEmyNbceEekjxRi+HSUfLjJ71vH
         jMSp0+KIRVe6Y7CzRwbazqtWbwnTovrKNtf28YWAkatMrOuMy/sYBczBmA+7cejpeOrn
         7GX9z8rUnQSQ4p6dtFyNd0W3IE7U4fRF+1Vh4iJsqsIGE2CGM4BOrl5cMCdowoi6wPzi
         FZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EK59YeNweTnOCzZsjEDake2xeFN5dYABW/jYJ1/liXs=;
        b=rnYC6mXyBpfabR+zKO041ILLpkV1KmGbY4d/s87abrazjbxs3K3evjUBens3tGFj1p
         w/WsRRR5OGZYO3PpbSoCSXamifgpO0eXbCLCHLqbmbiN56M5Vzue/GsC/QwjaLaG3lEI
         NWW33PX40xZImI0UHEuGSL5VSKeG0bgrHwIxod3E+t6FRjBno4KhThuuls0GKkLbdEiI
         gVGdmlmjLaVjTmVUQnlIHLGzR/mb1NFzOloenurq85LMHUEN/jhRHd3aOiqbIUeQxO+V
         JBw/JhDQORgU6+zSE4HsM1qprh6Q0NX8Kn0Tu6nVgpsZhxa/97EETK9fCnPqOUWZkS/n
         bGLQ==
X-Gm-Message-State: AOAM533EmWsEQgKzaJqLZWbtdPb1htVng/GNzsALKoFx9pA2mVk5IaId
        2mchyXnXPO0zNL8MESz/28rNDT/Xl9Cpkw==
X-Google-Smtp-Source: ABdhPJxhxZfzdoRp9QnxJ9BuI4SCkJgXZ7yoKqdHG/aEFdDq4Di8cGDjZaAWXItkOzItLMt5goL2AA==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr11928752wmg.75.1597615483734;
        Sun, 16 Aug 2020 15:04:43 -0700 (PDT)
Received: from kheib-workstation ([77.137.118.46])
        by smtp.gmail.com with ESMTPSA id b123sm28084737wme.20.2020.08.16.15.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:04:43 -0700 (PDT)
Date:   Mon, 17 Aug 2020 01:04:40 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-rc] RDMA/usnic: Fix reported max_pkeys attribute
Message-ID: <20200816220440.GA820535@kheib-workstation>
References: <20200805210051.800859-1-kamalheib1@gmail.com>
 <20200805221742.GS24045@ziepe.ca>
 <20200810201918.GA443976@kheib-workstation>
 <20200814165408.GU24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200814165408.GU24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 14, 2020 at 01:54:08PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2020 at 11:19:18PM +0300, Kamal Heib wrote:
> > On Wed, Aug 05, 2020 at 07:17:42PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 06, 2020 at 12:00:51AM +0300, Kamal Heib wrote:
> > > > Make sure to report the right max_pkeys attribute value to indicate the
> > > > maximum number of partitions supported by the usnic device.
> > > 
> > > Why does usnic support pkeys? This needs more explanation
> > > 
> > > Jason
> > 
> > Looks like the usnic provider is acting like the RoCE providers by returning
> > the default pkey when calling the query_pkey() callback, Do you think that
> > this needs to removed like what was done for iWarp providers?
> > 
> > int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> >                                 u16 *pkey)
> > {
> >         if (index > 0)
> >                 return -EINVAL;
> > 
> >         *pkey = 0xffff;
> >         return 0;
> > }
> 
> You'd have to check the libfabric provider to see if it cares or not
> 
> Jason

Looks like the usnic provider under libfabric doesn't care about
pkey/query_pkey, I'll prepare a patch that will remove the query_pkey()
callback.

 kheib   master  ~  git  upstream  libfabric  git grep -n query_pkey prov/usnic/
 kheib   master  ~  git  upstream  libfabric  git grep -n pkey prov/usnic/
 kheib   master  ~  git  upstream  libfabric 

Thanks,
Kamal 
