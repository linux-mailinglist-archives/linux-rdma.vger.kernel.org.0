Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CC270087
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRPHi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgIRPHi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 11:07:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905CC0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 08:07:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h6so5226775qtd.6
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bGY4rCor0u5Eau3BIdTI66aGuODEp9MaPnc5641O2v8=;
        b=XNRpSCLwXj4NAp4FBvi62kqhkQyhovgO/zvc5JHOD0QjULR+UHeJlbWdO6SuG5jPYw
         OKqtnZrGU1aYU9Nf2VWgdKZ1G7e7UmQxPQs3tSlGc/eC83enTIa9iVGqNuDZzVFCh2h7
         QK7Cerqj60OmlIQLAHSFE02ez+t49mdJAkZaekEsTj7WrFBU0nflv649z21ncc8QNdPf
         ho8gG/vtn6AuN2+wsRwUErjLWQp3A96FmMI/bQAEi2hJtlNmdeWHl3yQVlf83xwRdurQ
         IkuhMeo9fbUvK42I64u1yaiaZgsFtBi31hKwSNWUBVOKu7qXTedc2JslpFHMW34e21FL
         eQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bGY4rCor0u5Eau3BIdTI66aGuODEp9MaPnc5641O2v8=;
        b=c3wd+Ht4eSYIHjNAJDKLpwkYA/A3aVtVbKYm2C/GiRNYU1BvQx6zNfgvwLDBQol67G
         8qHXiucGTDWzGOnbHrFJDMQua7FGMiiurG7Go7rqpZy9jiA4DhUlCT/yR67Nz4IH7a19
         A36ogdNUfpgVDy4b3P/T4+zT28/lqC6RXsAfnSy7Mz6sSOHHqOVS3w35FvZRpjSaeW1F
         J+vtpfhfBPxTStn+Sws9d5vwxYHs7mIBcgzkSTaQrzZ8/nueMrFFAqj+8JNkZ/56jFHo
         HaSHEVIYbko0KATgNHWRllD4k39kqGqSls0RLGMhTeKv5pFTpH7csKLGN+sv1TAqgcle
         Ybnw==
X-Gm-Message-State: AOAM532L4UptW4cVYZkeswxkaJf8UFmY1Gnj+5E36TdFBzlov/niFHME
        qa+8tsE5kJ0SGkdZyho2nNtrzQ==
X-Google-Smtp-Source: ABdhPJwy5uvRu/OK3ajL4mx0YmxSA+e7kwb8stYYtaHEg8B5tNNmlKiChdKwjuYw/79vtP8EG43gmA==
X-Received: by 2002:ac8:1b92:: with SMTP id z18mr32542508qtj.265.1600441657528;
        Fri, 18 Sep 2020 08:07:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x43sm1290604qtx.40.2020.09.18.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 08:07:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJHz5-001IJ3-Ul; Fri, 18 Sep 2020 12:07:35 -0300
Date:   Fri, 18 Sep 2020 12:07:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, izur@habana.ai,
        Gal Pressman <galpress@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rdma@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 00/14] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200918150735.GV8409@ziepe.ca>
References: <20200918121621.GQ8409@ziepe.ca>
 <CAFCwf12YBaka2w2cnTxyX9L=heMnaM6QN1_oJ7h7DxHDmy2Xng@mail.gmail.com>
 <20200918125014.GR8409@ziepe.ca>
 <CAFCwf12oK4RXYhgzXiN_YvXvjoW1Fwx1xBzR3Y5E4RLvzn_vhA@mail.gmail.com>
 <20200918132645.GS8409@ziepe.ca>
 <CAFCwf109t5=GuNvqTqLUCiYbjLC6o2xVoLY5C-SBqbN66f6wxg@mail.gmail.com>
 <20200918135915.GT8409@ziepe.ca>
 <CAFCwf13rJgb4=as7yW-2ZHvSnUd2NK1GP0UKKjyMfkB3vsnE5w@mail.gmail.com>
 <20200918141909.GU8409@ziepe.ca>
 <CAFCwf121_UNivhfPfO6uFoHbF+2Odeb1c3+482bOXeOZUsEnug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf121_UNivhfPfO6uFoHbF+2Odeb1c3+482bOXeOZUsEnug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 05:45:21PM +0300, Oded Gabbay wrote:

> Any access by the device's engines to the host memory is done via our
> device's MMU. Our MMU supports multiple ASIDs - Address Space IDs. The
> kernel driver is assigned ASID 0, while the user is assigned ASID 1.
> We can support up to 1024 ASIDs, but because we limit the user to have
> a single application, we only use ASID 0 and 1.

If the QP/WQ/etc is HW bound to an ASID then that binding is called a
PD and the ASID is acting in the PD role.

If the ASID is translating from on the wire IOVA to DMA PA, then it is
acting in the MR role as well.

Bundling those two things together is not as flexible as standards
based RDMA, but it is not as far away as you are making things out to
be.

Jason
