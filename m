Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5058F253FA0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgH0HyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgH0HyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 03:54:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9AC061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 00:54:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so4238009wmi.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vc9jNKNI0Yuca0hZtJ2MAYHT8B91U5JXhlWV+QXIQ+I=;
        b=FD8aE7JWXus3kj+9t9IzKr5r7bu3skruGgEQtdT6DcACNKfJx8ZVAdw51+wBD7C/mI
         QNS/i6d6NkpPN91icdfSr+FNOf9kh1nV+eM1QHk3wijZaWhNYr+qLUUIa2/fm/HlY+zM
         VUGe/LxPQo69Z0rUPwilKSqAn8GPk0ZDNUsHxANK20l3iUzRE2PBHvyLMYEspHDCJdEZ
         ybUtpYlzqg+CNU3fSd7KHK7hSUy1wKTvQYeyBF/QBz5Ud7B81NS1svOCELzOAHj55lA+
         amLTO4f/gf9LuMVBsol1V+O+WpfJaF8ew6d2pyGm3a3KlivZm+66r44LITqJILsTnE2v
         V58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vc9jNKNI0Yuca0hZtJ2MAYHT8B91U5JXhlWV+QXIQ+I=;
        b=eRCsNYsIQTqCt7fFtBul5cHMv6AAvnIVkSmxxZLeVb9DxCpN1HXvBUgeM4FyCwFvZ/
         nSo4mdylMoo4AtDVB3AKwblERRoqW+/OqsN78Iu0+BhKlc82fZEamBYPFE1QDrByddFi
         xQbAIeSUYA4K0/EKGSF98M5wtwewLXJ4EfMXzmlBqS58T6D1CE5NcuBIAoi2E6WuhD3M
         GWR0pucqxFhfyY6zIDN6GOJAJHk9Z59fRe+0ti+L2ANK85oxmAhH78U4HEsJw6gZltye
         e5HCSZMi9zWPvpf2zjy/91nAUbUSwrrUxNrXfuug+jGUWXiRPMY60JtEHEy3GU+Z28sb
         8EcA==
X-Gm-Message-State: AOAM533LJVeFpnpOWlmRjZJzsKyW3RMADBCuvuxklWEaS4o0tk38gXU0
        49VzTF9Mw6WjI5/DzVTBrp4=
X-Google-Smtp-Source: ABdhPJwoZ6nJHk6fXRyqFAUP7qzBRW/tTGpjEKtwGV+RutIlD+evzZ7dOd7Raw1GNpPACh539z/iiQ==
X-Received: by 2002:a1c:2c06:: with SMTP id s6mr10933399wms.110.1598514839723;
        Thu, 27 Aug 2020 00:53:59 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id l7sm3329393wmh.15.2020.08.27.00.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:53:59 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:53:56 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Message-ID: <20200827075356.GA394866@kheib-workstation>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820135338.GA114615@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
> > On 20/08/2020 15:53, Kamal Heib wrote:
> > > Now that the query_pkey() isn't mandatory by the RDMA core, this
> > > callback can be removed from the usnic provider.
> > 
> > Not directly related to this patch, but pyverbs has a test which verifies that
> > max_pkeys > 0, maybe this check should be removed.
> 
> Or changed to work only for node_type == e.IBV_NODE_CA?
> 
> Thanks,
> Kamal

BTW, do the efa care about pkey?

Thanks,
Kamal
