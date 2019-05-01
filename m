Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED8107AF
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfEAL7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 07:59:24 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40956 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEAL7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 07:59:24 -0400
Received: by mail-yw1-f67.google.com with SMTP id t79so8123789ywc.7
        for <linux-rdma@vger.kernel.org>; Wed, 01 May 2019 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNiqa4YxYSig1SXVw8Z/UJe+i4CUrKvJ0IDQwidZ98s=;
        b=PdroslLAOgl9D6qRy2bWtrASSj842COkryuEXF0vgQf4UdOMPfNuXNmim1zTxCTowA
         VpRgwRIeVos9s6ns74M0cxmhSCEEUapMEC6wQ5YwYT7xNam8eP36hKClNbDQaGP2yX7q
         g09q7zmRiEy3xU8O6o6VmeMKhCS9sOYIKie4lDSqq+ug8JVImqim08WqhOE/LekRzUz1
         6C0l3DiP4QDk3ous//ZG1nXiGQq8O2vasiCVAklJGSb9BbpaJx9Z4jK0QMJkiiNnguPF
         /IpA2W4gT8KfS0EWrZxvV7iJN7JdAie7Wv8Yci+fJoyn+RZVey/+XnOJXQsMiXvxBHdi
         J8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNiqa4YxYSig1SXVw8Z/UJe+i4CUrKvJ0IDQwidZ98s=;
        b=pXN9sxNS1aSaRogLQBqUJz1jRfhyElDFO+z5S/SxCTYqt5ZtewT1NmE4G5pKE/w5O8
         J+Y2ikqf8UPMotkM9UzzRwO8WIHJxr1U8kbuUyFa2eQXwVKCvIql5tHZSKx9kd9PskcO
         U16EwRSsdaDTTlyj7WVmVqM9xZb2L8Ocj7q/sl5EvrurjuiT+B7dPv12hBbAQpbwwO/u
         Ucps6p1J11j6aDFkPbL+TvhL/DDI20YuBWk4/pEiECO3z9BH8DPFzrsnzPRum3iDvNCJ
         c5gb4fdsCQBVoz8/UvTZh0JOmCUNfrWAHUSMffgaOvj51XV0dlMIQ8r4BZorwIRMU09t
         g00g==
X-Gm-Message-State: APjAAAU2t3X9CkJ71VvT0CkVXVfetM7Siuch7JFigReZUAdKBIigQFK6
        DyNDSSdOI5dUhEZ6ALkHQhvuQQ==
X-Google-Smtp-Source: APXvYqza5XXUC5ABQh4l1IakPWRYSOntDKIMLa4qOqXk3XjhLMCALY4D51IwQc5Z3ZejrH0vOUWtRA==
X-Received: by 2002:a25:e68f:: with SMTP id d137mr60378896ybh.256.1556711963463;
        Wed, 01 May 2019 04:59:23 -0700 (PDT)
Received: from ziepe.ca (65-23-217-40.prtc.net. [65.23.217.40])
        by smtp.gmail.com with ESMTPSA id j14sm262492ywa.36.2019.05.01.04.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 04:59:22 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLntO-000349-UU; Wed, 01 May 2019 08:59:18 -0300
Date:   Wed, 1 May 2019 08:59:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH for-next v1 2/4] RDMA/uverbs: uobj_get_obj_read should
 return the ib_uobject
Message-ID: <20190501115918.GB10313@ziepe.ca>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-3-shamir.rabinovitch@oracle.com>
 <20190430175408.GA8101@ziepe.ca>
 <20190430184249.GB30695@srabinov-laptop>
 <CALEgSQtXOn9QhnSySfKba8-kSK+crMdwFB5P=BSR-pYq8K6Psw@mail.gmail.com>
 <20190430204602.GC30695@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430204602.GC30695@srabinov-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 11:46:02PM +0300, Shamir Rabinovitch wrote:

> (2) Or leave the uobject pointer in the ib_ah and just use it in this case while
> still modifying the macro for the sake of the rest of the code. This leave us with 
> same situation with regard for object sharing.

This is my preference for now..

Jason
