Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F1290DC9
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 00:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgJPWhh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgJPWhh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 18:37:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42FC061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 15:37:37 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w17so4396765ilg.8
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BhRh0fVUEaCKulmiINWwp53QpH62BcdZU6KE0N9EDno=;
        b=n3TGQ90E4GrgU2F6xjIP6NtR2VeJgjvESwpzK25JMfaIkMvGV0jWLzBUU9RV+G4dY3
         1UzVwrwZhy79T9dnfQsPptynr9DQL+kmncYRTVyysc228CRy1oHRE83jru4r1sxEkfm6
         zWNZtq03VwNG2y/zvIMUWq1mahSFPge0/SWLoOpmHdz60LUOjjzbA62KO8c0cGg+zNSr
         aRhbPkUc3BUqDedYH+njI7d4/7ZCn4qlhZxdOV9JHhMripivzm8EhTWNWxA/NQGQ93Uh
         k5tk2qJ79jsvJavZYgbIx5zGGComMa3e8kJFgAEAm8Qnf0LWci54fiGeaWJEtiEVd5w0
         N1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhRh0fVUEaCKulmiINWwp53QpH62BcdZU6KE0N9EDno=;
        b=Q1/KDtJG77DNKFB2mXWFbHJ+A3PP3365C6GeY6TQdH0BMf2G8Pz6whPqQatgQ7Uosx
         d96+Pbz0ttowUyWF4g7VTOTuzfGby7dgGZ4qSB2Ce3XHUSnCzRZJ7jXhFnzHK8qQOl/P
         0hrlPTXFQp1iAobonIKvOdZkmUl5nJco1vdm0NlyNfzijhVk5NdZzuipv+wUCfldv7GL
         NTfdbMb1lGgeIcuC6lVN95UxMyDDucQLuclO8+E6LYstpA3LdaIs4owCPgCD+SPYFDEU
         w0lV7GAqHZ94kq8QkWnJ28XUQ9VOuW6PFzjJMRXpbBSlKNb3l7xmLS8bqOCOZHNjb4Fw
         b12Q==
X-Gm-Message-State: AOAM531SzhiWRxKoAyoG68WRC/RVWs1E4YFc5m9Agvm3qwHinXrx1NeQ
        //Bg4uFsWeIo44WH8YRuRn+Rvg==
X-Google-Smtp-Source: ABdhPJzpijh94ExlyAfTD2d7EaTie4B9V5UIz5BT+yHMcfYtmy/B1nmKL11vKZ1qG96QflCbWfsyNg==
X-Received: by 2002:a92:d9cc:: with SMTP id n12mr4114605ilq.122.1602887856640;
        Fri, 16 Oct 2020 15:37:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c8sm3070802ils.50.2020.10.16.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:37:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTYLu-0012MN-TJ; Fri, 16 Oct 2020 19:37:34 -0300
Date:   Fri, 16 Oct 2020 19:37:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Question about supporting RDMA Extensions for PMEM
Message-ID: <20201016223734.GG36674@ziepe.ca>
References: <8b3c3c81-c0fd-adb2-52a9-94c73aac7e37@cn.fujitsu.com>
 <b7cc3571-5c4b-d5f1-d4e4-97afba4a7994@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cc3571-5c4b-d5f1-d4e4-97afba4a7994@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 10:26:32PM -0400, Tom Talpey wrote:

> In theory, the IBTA SWG is in control of specifying any Verbs changes.

SWG and IETF should agree on what the general software presentation
should look like so HW implementations can be compatible.

It looks fairly straightforward so this probably isn't strictly
necessary once the one the wire protocol is decided.

verbs has a life of its own these days outside IBTA/IETF..

Jason
