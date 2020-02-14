Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7319115D5DC
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 11:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgBNKfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 05:35:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgBNKfh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 05:35:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so10279414wrq.10;
        Fri, 14 Feb 2020 02:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d7W1kdbHZqWV0I8rRc8UL4aroe3yEEgP807NUkElh44=;
        b=rmntURPkIoIZcotuYijTnwMcaJ2d0HXv7V82S+K4mL6fc0xXjU9BPy3QV4AKl7k+RX
         lcEJ/NKh0i/JdMiLLmHFRp3ZDQ8cqsvufuQa1h5Y+2Yli2ehZh74mNX8LkmbPed3/opo
         TDTuZyrR2/owku+wvr7eFoSWWVTtF7AnF2+YwrR7v9VAL+F/tCdSJkBn2itBDlRBoWX4
         KNzDiz+Ushgmy4HviSYwlfe+Npuncb2yOqrTQuN9kwVlE7Sup4hJJzsA5D/RqscCuMA5
         1YobqgUB/+A5QE0Jm6PvOr5dP1pW8MROJius+DHYTkWRrq9JocViGZZONdIGEL8vRNRZ
         WB+Q==
X-Gm-Message-State: APjAAAU5HWhR1grC0OYDhCW2E+7Amilq5SozAEBQPqlRdnHZ01Ix4zxe
        VBruuCMVgU7sdvBNd9ysfdI=
X-Google-Smtp-Source: APXvYqxRqilIpNGUEWipv7odi3hZcxmVRPxaGJ6+TTBzUNyr4734mUC6t2/YruBJvqTTxvAKh5cwyg==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr3556774wrm.150.1581676535349;
        Fri, 14 Feb 2020 02:35:35 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id v8sm6607606wrw.2.2020.02.14.02.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 02:35:34 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:35:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200214103533.GS31689@dhcp22.suse.cz>
References: <20200207182457.GM23346@mellanox.com>
 <20200207194620.GG8731@bombadil.infradead.org>
 <20200207201351.GN23346@mellanox.com>
 <20200207204201.GH8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207204201.GH8731@bombadil.infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri 07-02-20 12:42:01, Matthew Wilcox wrote:
> On Fri, Feb 07, 2020 at 04:13:51PM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 07, 2020 at 11:46:20AM -0800, Matthew Wilcox wrote:
> > > > 
> > > >  Christian König <christian.koenig@amd.com>
> > > >  Daniel Vetter <daniel.vetter@ffwll.ch>
> > > >  Logan Gunthorpe <logang@deltatee.com>
> > > >  Stephen Bates <sbates@raithlin.com>
> > > >  Jérôme Glisse <jglisse@redhat.com>
> > > >  Ira Weiny <iweiny@intel.com>
> > > >  Christoph Hellwig <hch@lst.de>
> > > >  John Hubbard <jhubbard@nvidia.com>
> > > >  Ralph Campbell <rcampbell@nvidia.com>
> > > >  Dan Williams <dan.j.williams@intel.com>
> > > >  Don Dutile <ddutile@redhat.com>
> > > 
> > > That's a long list, and you're missing 
> > > 
> > > "Thomas Hellström (VMware)" <thomas_os@shipmail.org>
> > > Joao Martins <joao.m.martins@oracle.com>
> > 
> > Great, thanks, I'm not really aware of what the related work is
> > though?
> 
> Thomas has been working on huge pages for graphics BARs, so that's involved
> touching 'special' (ie pageless) VMAs:
> https://lore.kernel.org/linux-mm/20200205125353.2760-1-thomas_os@shipmail.org/
> 
> Joao has been working on removing the need for KVM hosts to have struct pages
> that cover the memory of their guests:
> https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/

I do not see those people requesting attendance. Please note that the
deadline is approaching. Hint hint...

-- 
Michal Hocko
SUSE Labs
