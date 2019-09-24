Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CEBBC7EF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406336AbfIXMh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 08:37:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40129 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405807AbfIXMh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 08:37:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id x5so1882072qtr.7
        for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2019 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yp3AYLHOywUCVFY3QAsWRHLrjZaQCclRMUX6ax4rKog=;
        b=Tx02qiTk4SDc5PLhw85ou9/nEFo7Szm22vXuKiiTekXMRVUbw9kOqydtYJ+1i0YAaU
         SUn9Rl+YAXCW4XnU9Bk0ZtP2sH5G5x+FJeMQgwsC/JgiqdRr7rAmd358e//PeoXz4M1+
         HT4sLRNLRVvK80ZIhXorKMFEykztWR4ydqgKouO4iIMLgvWWyzOBmxZ937dyYpADY79N
         NfR3AgJkGUOV2eHX4kj1jJ8+eocn5XDhmH8KCSZ5i+KIGrkMdvgpKgjfcyWs2c9slplR
         sEml/Y4trYhb2P0HHuH27TyPJCOBFiE7MTM2IISLccNTDPTmylfqGKFa/osWwf/yTtjT
         aAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yp3AYLHOywUCVFY3QAsWRHLrjZaQCclRMUX6ax4rKog=;
        b=TBymI0Np/LLx35TRx+cynQqJ+JZWU3Gt734ceD8Ieg3k0rh+Z4UqdFxq0KuYyKaIeU
         DfMalWgTnMjNInYnMpOaMKKl+2kel67izutSd6nhqOsNg4J10vl9n+xIUr89D7Cgvh/U
         YKO+aKBkt5f2BeptbPPTBRi/7oFojsE8kpbGbfRVlZkIeAugHWltOlT01f6KRebOsSLh
         PyHp4ndY9LPaRUVSkte48LGoPSL8zHV9MyJagQ0aFCit8B6jZZ2HKB8oiXaU3IGnGuDF
         IGA+f1KA9dSaQnb7HiLnRj/Sthe/dq4FJapXcJlwDja+nc7BNTty8SQYXf3QX0cbHAVi
         2PFA==
X-Gm-Message-State: APjAAAVbv4DEJhNHuG+vQCPwMDFgYpxgL8QjF4R6Zgf7WmVuRryrvxW3
        luOW2LIG+7akwORF4ajf7EEz8j5uw1k=
X-Google-Smtp-Source: APXvYqxFM8PiI/VMtcXu2zZfsGxrGdfU7KrObLKSKHnH7Bo6RIy+BvKsBb/6FtN9dwGHA0uLIjUkZw==
X-Received: by 2002:a0c:eb4b:: with SMTP id c11mr2184485qvq.154.1569328639462;
        Tue, 24 Sep 2019 05:37:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id t17sm1298423qtt.57.2019.09.24.05.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 05:37:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iCk4E-0003lA-Fr; Tue, 24 Sep 2019 09:37:18 -0300
Date:   Tue, 24 Sep 2019 09:37:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Message-ID: <20190924123718.GB12296@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
 <20190919180746.GF4132@ziepe.ca>
 <MN2PR18MB31822DCFCA312D6A455A000BA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190923133000.GD12047@ziepe.ca>
 <MN2PR18MB3182E0034A68DF1452BA73C6A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182E0034A68DF1452BA73C6A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 08:31:16AM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > 
> > On Mon, Sep 23, 2019 at 09:36:01AM +0000, Michal Kalderon wrote:
> > > > > + * will use the key to retrieve information such as address to
> > > > > + * be mapped and how.
> > > > > + *
> > > > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was
> > not
> > > > added.
> > > > > + */
> > > > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> > > > > +				struct rdma_user_mmap_entry *entry,
> > > > > +				size_t length)
> > > >
> > > > The similarly we don't need to return a u64 here and the sort of
> > > > ugly RDMA_USER_MMAP_INVALID can go away
> > >
> > > So you mean add a return code here ? and on failure driver will delete
> > > the Allocated xx_user_mmap_entry and not store it in xx_key ?
> > 
> > I'm not sure what this means
> > 
> Before fixing: driver allocated rdma_user_mmap_entry, receives a key and stores
> The key, if the key received is INVALID the driver frees the allocated entry. 
> Wanted to make sure I understand correctly that you're requesting I change the
> Function to return an error code, and on success the driver will store the pointer
> To the mmap_entry structure and on failure free it ? 
> And the driver will not hold the value of the key, instead call a
> helper function if it is required ?

Yes

Jason
