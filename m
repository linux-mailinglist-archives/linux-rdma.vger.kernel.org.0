Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5746A078
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388592AbhLFQEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 11:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388042AbhLFP7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 10:59:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF14C08EB3E
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 07:42:02 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m186so11505651qkb.4
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tv30VS8SeKlLP5GRLFT6OKvsf2r+6PIvjSUcqekajik=;
        b=ideCG96xgNqked4pgV6jazA+7DiryfKsZEADsB50dAmAVoQWQ4q2pulV7OagAlM8SQ
         6phVT+EG+Hp4unV7lOISRD0QAojl3NXKQhZh56HGo3Qvce3nSBnzaQ5Evov2KGCMWzyW
         PF9wp7D5SaIhcxVR5jXomZ4VTfCin+W8shzA85ab73pCx479nJaDzJP1WTngj3RU3FVO
         KjUwmnkL6NwBn9rWVhTfvpIDgGXeyRyzwygHgoebHNNbA0Oc228naVW7eQ/7v1E0s32p
         ZL42Eh/1KgCVtQ2e2Hv9nn/V68GyKo0abJRtDL+XtYZr524pDxNKLmo5BlYEmHrtgiMq
         lBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tv30VS8SeKlLP5GRLFT6OKvsf2r+6PIvjSUcqekajik=;
        b=oSJPViAI9tepUcMbm4ILawhBxXguf+DGXzgo6+gcJHGtEFARXrYPYrOuqMRRzYLxxQ
         W9gCr0TkbduA9kV0OBPiS5DsV4GXpgLUVTHDRs8v7ijsfL8bvJ2YpuncxAFJMjqNQu38
         nsr0/ZVM4KwPdhjB8nSSbPQ07FRwQOQ498Zjl7coQ8+aWOe23u2/+lbyIEV9x8t7IW48
         w3b6xStwg54jfMYX9X2YSB1gpDpDRmjH9kS8x0IexUvOVQWoTgU9tOBEDYHP9ljHNPkR
         ydt5gjd01VNfEkb5fb+ul/L9aTox4jFr0+cXV/7JQo2cHptrRX7QpxMJPapIJJZD38uN
         Yrzw==
X-Gm-Message-State: AOAM531w+b1SEZM3IhWU4pUS0HgWJZ+hTTdamn2JbZSBVAGrIeqMQzY/
        Rdv4YxuewV2/b2b9rgfEHSI8XwiboAJLiQ==
X-Google-Smtp-Source: ABdhPJw+NV2Qe6hp/inCJIC+GhFU4fEbYd9SO3EFcw0nOYD9MI9icSOOAhJ6rOWIykGB0U3g02NFxA==
X-Received: by 2002:a37:3c4:: with SMTP id 187mr33417527qkd.755.1638805321335;
        Mon, 06 Dec 2021 07:42:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e20sm7744887qty.14.2021.12.06.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:42:00 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1muG7r-008xwn-TM; Mon, 06 Dec 2021 11:41:59 -0400
Date:   Mon, 6 Dec 2021 11:41:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>
Cc:     avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
Message-ID: <20211206154159.GP5112@ziepe.ca>
References: <000000000000c3eace05d24f0189@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c3eace05d24f0189@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..

??

This commit is nearly a year old?

$ git describe --contains bf152b0b41dc
v5.12-rc4~28

I think this has probably been fixed since, why did a report for such
an old kernel get sent?

Jason
