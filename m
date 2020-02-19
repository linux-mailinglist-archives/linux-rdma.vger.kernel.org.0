Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8933E164B1D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBSQyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 11:54:25 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:34190 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQyZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 11:54:25 -0500
Received: by mail-qv1-f54.google.com with SMTP id o18so496124qvf.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewd+6K0ltgfapzPCvC32inRerzXtvxjbi3PS9IGE+aU=;
        b=m/qnkEhTjED3fcvtAm1+ug+559Fu6wWY4qFwBEugWjaZdT5RMR0iMxwofZS/gRS2cD
         Z6MPRjv3tdfFguTqqP9OFnlkFDH6TpxIBhFfC3Gz8CO7fTtfJAatpVUdvUCESmBRDzto
         R8HMeaiILYCmUHEH9YimBcRpwRnBaFVFfPsFn0QEZB7I0lcR7VM7w2pywMKQTOHGTQJ2
         lppuaG6N3VHlh4VVgImWceRyfM18JMSOC5wJLl3aQgjzZODBs5jsidCY/w/CIqo2pkhs
         Sjs82zCMV1TqYbvy7b85yZ40UWoSYw6bqt18TDfsGVi6DHQhIICUyTMkHqfDjwNkQBQz
         L6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewd+6K0ltgfapzPCvC32inRerzXtvxjbi3PS9IGE+aU=;
        b=JclX4WhCapv7LLgZd+kV8w9P+Egt7a51p19O0Cum8O7G/rweBXRmTvmWANLECUYfVn
         q9rdzdNSetSPPb6LTEdi9aHrdrYHlaEvGaIfRxBR5mMJIcaaeREdD9V4kTVq7TJDNu+R
         kQXwQr9CgfWDIcCHcG02O6zecgub76z4HVAGHctpiJUiRlZqoR+1jBDXHLLxEqe2QNgp
         t4HrKdsSQHGdjawPD3L8zf5yhYOIkRlwXZVI74sFZ20rKcXdfcs3WKzVouvucHXebLyV
         UjNWkGnAy1Ank2G3Gt6b85tvUshSquoD1BAhsYtUU6DGezxdQmtE+yMObIUzzqhepe8f
         t9mQ==
X-Gm-Message-State: APjAAAX83fmg4hTK9eixz2A/U/Hsr9nLOX3HzrTPAbi+Iw4Fi13oBwms
        8BQ4/mlLcAx+KELDlR9GonbnzA==
X-Google-Smtp-Source: APXvYqzEkE0MVDS1yZkqbFhNXAk8cGfwymj0VbsHwSMUqJf8G6J1A2Z4IyKL05D7dUUc0E4cmpGEqA==
X-Received: by 2002:a0c:f6c8:: with SMTP id d8mr22277774qvo.234.1582131264316;
        Wed, 19 Feb 2020 08:54:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n189sm123306qke.9.2020.02.19.08.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 08:54:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4ScB-00059X-70; Wed, 19 Feb 2020 12:54:23 -0400
Date:   Wed, 19 Feb 2020 12:54:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200219165423.GR31668@ziepe.ca>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
 <67915d24-149a-e940-1f0b-a173eb4aca84@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67915d24-149a-e940-1f0b-a173eb4aca84@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 04:35:40PM +0200, Gal Pressman wrote:

> > Again, call it what you want, but you can't deny this change to force the rename
> > by default has not broken things. For the record I'm not even talking about PSM2
> > here. There are other, more far reaching implications.
> 
> It's not just PSM2, it broke our libfabric provider and apparently MVAPICH as well:
> http://mailman.cse.ohio-state.edu/pipermail/mvapich-discuss/2020-January/006960.html

You all recognize that finding stuff name dependent stuff like this is
horribly hacky, right?

The whole point of doing this, over a long time, is to get all this
hacky stuff fixed up.

> Regarding the issue you described, why not disable the rename on the upgrade
> path and only enable it for fresh installations?

That isn't really a rdma-core issue, though?

Jason
