Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4190278A54
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIYOH3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYOH3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Sep 2020 10:07:29 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBAC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 25 Sep 2020 07:07:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cy2so1413659qvb.0
        for <linux-rdma@vger.kernel.org>; Fri, 25 Sep 2020 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ky8MreI3OvNL2vsDZr1bzR8znuBSqWm9TW6JUk7GecE=;
        b=M7odxUL9heq1xTIMokyrxqVVGLMRabM0IGGh6FHY0y0CNW/j5coU0ghL3vvYxk/oV/
         oE09Za02EZ0+lTOfiITK+jWeqfxc5DyhxyWi4MPGZCIxhMtWb2/9KJU3DSdf62TXc+vc
         s1cONPPhNBq7G0pqKeLjuUtTMF99wAjtEsgA252H5OAKRXbcROcK25gZM7UC1csIt0eu
         mjZACd3BSLDU1op4Xbj3tTAqFbQyK8kPW6IspYxZa9CmQztTTEYcvbdj+dnjH5s+fCMD
         dsujfd83Tef8Vdz5btoqsIQQWU7q1ZNoebcIsDzKBQr0MIYsIgW3KqEbzgJAddxt9ngV
         3Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ky8MreI3OvNL2vsDZr1bzR8znuBSqWm9TW6JUk7GecE=;
        b=S7axFGttdPfmkVevihw8U3ilApn5GuQQyElsNBdqmOG48oKoCrJy34JHUKVXat20Bx
         PiYzrK/s2VVs8br8EgDL1xS8vlxMNGYDmPs7Rx1l4YYzlhnNPn8gHikuIw3sn0DhwQTT
         IUsXRyF5for5fwed3vILTkqlyjd1nDk0qANWykoqnnAkqyhzdx1HGXkD51g6QpmkL0ah
         JhhYtTLxpZtdUXdPt7JECx4J45QrRQHYxMy7ibWQtn9jqxMaF8Pg0x5HUrqCMjTQW8KT
         5AiB/DRpErlivbF6JZ9PRbsURe0l/Y6Tu48CJfkcr+PDUHxT+xO1yoGZDTVLeD962M0D
         Wqhg==
X-Gm-Message-State: AOAM531TL0gSWxjDALOsFR2o04R/da1733XjHH5ZUnK9N5iMmIc5cALM
        Mj10QPllwFT7MavNUx0Vys7ytvXbKzaP0QAT
X-Google-Smtp-Source: ABdhPJzlR8wK8aQM2Vy2d/Jum9pkDiZHXLv87MG9NYukRz44eQfEO6pXoFiH1qfNC2Yt6OfPDpb6gQ==
X-Received: by 2002:a0c:fd42:: with SMTP id j2mr4779835qvs.37.1601042848138;
        Fri, 25 Sep 2020 07:07:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m1sm1694496qkn.89.2020.09.25.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:07:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLoNi-0012Nj-SQ; Fri, 25 Sep 2020 11:07:26 -0300
Date:   Fri, 25 Sep 2020 11:07:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Edward Srouji <edwards@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs regression
Message-ID: <20200925140726.GI9916@ziepe.ca>
References: <5c484f6d-364f-834d-0b16-144be92fc234@gmail.com>
 <1fb57743-20fd-1316-8071-cc3ab056e582@nvidia.com>
 <CS1PR8401MB0821BD9BEF78160638B4C7A2BC3A0@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0821BD9BEF78160638B4C7A2BC3A0@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 04:34:52PM +0000, Pearson, Robert B wrote:
> Edward,
> 
> That problem was resolved by following Leon's suggestion and
> deleting the build directory. I do not see it any more.

It means some make dependencies are missing :(

Jason
