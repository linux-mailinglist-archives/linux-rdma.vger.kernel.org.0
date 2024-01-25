Return-Path: <linux-rdma+bounces-746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155F83BE9E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C312FB25965
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB01CA94;
	Thu, 25 Jan 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2ANjwE/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762931CA8F
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178314; cv=none; b=UTifBX7TILU+glpWKbE58O4CXrFmiUyDHkv8roKJ7nkWKT0K5XdvqM483F0Wi5MEiN65RU5QrRrTAcZODWolRIsFH08QB4TnrLhimlIxK7zId7B6IIm1L9KUarRZtqXS7Q3xYZXgdO8HykC6+K4J6QdkZsssJVuYaQ6XZOAseXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178314; c=relaxed/simple;
	bh=2htcUWYKQpBXI+onp9NXnOvabopOqkWQ4GcYFeznM2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLSDR5TQnw8Tm0DGa2i2NirD+HlUpaRy91mHhlnQzA/WPTU6mCLqixn2dkeCNI9oHyI5nG48au+3tYrbUsbpgnzNE4GvrPy4eFkfY/ED7y/1w37UGfN6Mo92+53Vswcrs83tvsLgBjA6lVXhuZQF3b+6fB6nRsIaKAHoSboAtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2ANjwE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAADC433C7;
	Thu, 25 Jan 2024 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178314;
	bh=2htcUWYKQpBXI+onp9NXnOvabopOqkWQ4GcYFeznM2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2ANjwE/pqcZk4DGvjyWPloS9Kp1TZ28m8MjgFmKC9PFK8n9v0yGeUPt5hrpq4v9i
	 HQiw7rm3VFXsLk/27elwe9VeXPH7fVxh0TZRWwfQZlO8VDgW6ywY5oTgxHmS9l3ycY
	 afhG1sC8cUi33grDCm2xN9kQKi92fmnufQLXcbrgGcnkqJ2zAbcE4CLV+1VvXW7rqa
	 Czx6LfgWcVJs0LcjPNZxK5ybvTwC+DogX9KW40MwkFL+pQjP+vbT08ia8yF2wTgwkp
	 IKghJxjNSIbvA17lOc+L78W58UxqVcMkgdXG3GgGFx+NuPXJoYmuDJtoKB9NzBB64X
	 shZOlZBoeycNg==
Date: Thu, 25 Jan 2024 12:25:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Aron Silverton <aron.silverton@oracle.com>
Cc: Nicolas Morey <nmorey@suse.com>, linux-rdma@vger.kernel.org
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Message-ID: <20240125102509.GC9841@unreal>
References: <8a4daa40-5702-402c-ae80-3f969ac823e0@suse.com>
 <tax7ypiihhjimf2qvdoqpcwobbm5jwwf742dw5hs3a662orsf5@o4lg3z66sbnp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tax7ypiihhjimf2qvdoqpcwobbm5jwwf742dw5hs3a662orsf5@o4lg3z66sbnp>

On Wed, Jan 24, 2024 at 04:05:08PM -0600, Aron Silverton wrote:
> Hi Nicolas,
> 
> What is the rule used to determine when older releases are no longer
> supported? Can something be added to Documentation/stable.md to explain?

My guess is that it is Nicolas's desire to keep this list limited in size,
at the end he handles alone all rdma-core stables.

➜  rdma-core git:(master) ✗ git show v29.0
tag v29.0
....
Date:   Mon Apr 13 14:53:55 2020 +0300

v29 was released almost 4 years ago.

Thanks

> 
> Thanks,
> 
> Aron
> 
> On Mon, Jan 22, 2024 at 07:33:36PM +0100, Nicolas Morey wrote:
> > These version were tagged/released:
> >  * v29.12 => This will be it's last stable release
> >  * v30.12
> >  * v31.13
> >  * v32.12
> >  * v33.12
> >  * v34.11
> >  * v35.10
> >  * v36.10
> >  * v37.9
> >  * v38.8
> >  * v39.7
> >  * v40.6
> >  * v41.6
> >  * v42.6
> >  * v43.5
> >  * v44.5
> >  * v45.4
> >  * v46.3
> >  * v47.2
> >  * v48.1
> >  * v49.1
> > 
> > It's available at the normal places:
> > 
> > git://github.com/linux-rdma/rdma-core
> > https://github.com/linux-rdma/rdma-core/releases
> > 
> > ---
> > 
> > Here's the information from the tags:
> > tag v29.12
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:29 2024 +0100
> > 
> > rdma-core-29.12:
> > 
> > Updates from version 29.11
> >  * Backport fixes:
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMEQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZAHSCAC5n0oppCMuRdf+lMKeb61kPxBS/gD1xLcY
> > IyUI0YYSOLLQxsrjyp+2MUAPt36KvBRj5kFInZoXtYu9Gn38i4y+pBTXk08N4rri
> > GKGLRJxU2hkKytAmn813ocSVLrtIJiyQEl0qdq+O2PK0aKxiKy234ZOp7adMpweX
> > CWaC2g509QY6JUjkENaosA/+sXdSU1mwiEfY4J4xjjVaGcFinCt/pXHPAGeOE3sL
> > 97M4Hitgk28Jqy44l08QYQ0y45hjdrGbY2GKP6iIpGgkHPwHI6jRKW0E0d877Ml/
> > xd38HqSAYJY+nje10Bn15qEFahNcj0D7U7rvtFaEVVIK+hLwqgtV
> > =s1mc
> > -----END PGP SIGNATURE-----
> > 
> > tag v30.12
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:32 2024 +0100
> > 
> > rdma-core-30.12:
> > 
> > Updates from version 30.11
> >  * Backport fixes:
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZIzRB/9CGxKOOIAVWpXiUVTYxEAygQs7rZpN4MYR
> > 0h9aVswgLSZNpxb3UvmyCA6264s+6j2ZDheQ7UnPr/Zs16XLWq0CL0+qrWRYnD+u
> > F0VZSoz81lqadOA/9TNz3XLN6UBUkFRzauwb76WyYdOnsRHYDiUjwgqUhkMR9MTV
> > qYvWyZhPZro+1GItKD+FJ1g/1e/vtKzQzFEnHLv/AH2p5CgmBOFfmVgPYZZAdIjV
> > KVSMKaBbtNNjaV/A3996Z0G7251Zo9GIYHpKzuwk8U0cWjQzAKhdoXuC+UlQLrCN
> > rRh6u7p9cj2oZp/rGg5Z56/PbZCfPMLXqMXSb6AfxWwuwOd3yZtm
> > =GwHX
> > -----END PGP SIGNATURE-----
> > 
> > tag v31.13
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:32 2024 +0100
> > 
> > rdma-core-31.13:
> > 
> > Updates from version 31.12
> >  * Backport fixes:
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZBZuB/91A03upT+WfvFkV3ZDy4ei2pUJOw0EV9G0
> > dSRauUZgWkOb90hgFdFYOKSyq90ChyNhsDyqOVlEppBWgjr67kSjPjmR2pX8m33y
> > MYiU56o8c51XsRF5lGjVPuT8Qf4y8lPOizylVC9pN2A/Wtx++7sYOgs7pYuzFiQY
> > j0XId4u1w8XgtgDIcRKZwDpPy2o/fCoW4ps1q6nYI1BPXW+Y4B43ova0OUnGRt5Z
> > ehSUThcpOkRoyy3+058ylO+ZhSjEIbigy9RwVUyQebD4mmWwnhGLvmx/Cct930tl
> > g9oPPg2KZEplXtUgUAynY9r2Q69z1YP4phNcd80MJp+tlst6Dp9Q
> > =JVVd
> > -----END PGP SIGNATURE-----
> > 
> > tag v32.12
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:33 2024 +0100
> > 
> > rdma-core-32.12:
> > 
> > Updates from version 32.11
> >  * Backport fixes:
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZMXiCAC2dVGWr3MIZVJzCQyv2DU2cPzxnyKYyWcE
> > EhyIWMJ9vfpJxTHpSW25769c+6U0r3OBnx+ynGrzsqZSWweeASx1iVjFJ0RJ2wFP
> > eYsPEU9kTpb4fn1jjccl7VlBFaE7se99Thdc22yhOJ860JHOQGKFMY8rKFa0sTYZ
> > Vs4DBnj2A1g2AFwkNhaaJvY2F2mKT0khyTA2RnfuxVE33epcbwObU9XHT/f8tV5B
> > 7uPSZCzaBUSgoKz2dHy+5wT0AXPK+73WsIpWK4KxhE2hEjC48v9GCQwcuHNSrgpz
> > y3UHWyotg6sh02qjjGc4NZMfXQxGEjE0GU/dTHUg6haCqYJWXDIv
> > =vxio
> > -----END PGP SIGNATURE-----
> > 
> > tag v33.12
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:33 2024 +0100
> > 
> > rdma-core-33.12:
> > 
> > Updates from version 33.11
> >  * Backport fixes:
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZDVHCACU5Mr8AQanuwreHd4+fBUhK30NVUlKcQbJ
> > eJ2CK28ZBrmZbIhPAzQBNqHL0TlIiDB5jshtYgYXXXc7qwIJNUSIEqTjnr7ijdTi
> > zTTW0lWrfOEh1pcqjDe9gPhGamjsCUzGNkTmGtiJpS7UY4ubgWeXgWVtUK5ttkn0
> > 7TUvmZvpvhF9H0t5fNwpbyhtwCjRAidS3Q7bbDW609DrbF816/vT9CbpIHZ4q58e
> > WTBKuJhRt4+nG2XXqulqDilf1RmH0i+xNcaFwemKS17LY6wPn/e4zDXW9MrDaPkX
> > 6Vz7h/8+kQdHmCcRdQ30vhI/utBJOH/zcopY1Od3Kp1lgW1P2TnR
> > =sIHH
> > -----END PGP SIGNATURE-----
> > 
> > tag v34.11
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:33 2024 +0100
> > 
> > rdma-core-34.11:
> > 
> > Updates from version 34.10
> >  * Backport fixes:
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZNugB/9G9bKbd7FJfbwTFvvi2mO/sioNJTHI88Id
> > hm5P7LriVQHLCjzO5PSCxBuK/quU40B4xS02yCUmvD6i0jIfwf7EUX1GiqC/JWj8
> > UXPhTOlKc3EngzOw7xYMHWq/mslGkN8CGwEjtNFVT7nec8XwC2Ux3ljetu7VIZB6
> > O1NeDHKkxSOeBljxA5GmLFqsehGjt54TcpT0cQhQuIOYfEMHiR7soR1NzJMNJ8/S
> > jTdEVrStatI6aXBXcEhgTky2mBeh8v2xZxOwqRyYTYzRxFKEHGNW7+t2UHTk3h/g
> > QJC9hFdh7ZwYC3oZOgXMFtwe785cesRuApcKa87OIayyT9TP+UUi
> > =qJA3
> > -----END PGP SIGNATURE-----
> > 
> > tag v35.10
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:34 2024 +0100
> > 
> > rdma-core-35.10:
> > 
> > Updates from version 35.9
> >  * Backport fixes:
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZAwjB/9ntUqmIEGnzNjPXr8izK9A6cYIqMFr8HAR
> > krfZiUDdvbMf/qSfmfYiHZMn6ymFl6tV8nJzLB9pxqNcfcdP5+4oF3B/XpKeMSmr
> > VRf0hmpXGEEk4c+DNhIfAI/xT9GJDoUt2oIRHiggBMab2Cg8YIkK/mru1J0J4XYr
> > HOaf7usRrcCMxvN8+aeffOPDFAVqEyNYMBEzxiukO7kVwg+fIXL8o4z8JgFN6USm
> > txxidSRaCdd9B6bTKT/Z08V0w3CVfp5x9NQlXnVKOf7aplye2q9FK3Ecq4Q7hCKn
> > Tf6LsgT3pO8vT749Iu1hm/cfecIvCHVoCyNVUBtIh6nbAJvUm4CT
> > =F8k8
> > -----END PGP SIGNATURE-----
> > 
> > tag v36.10
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:34 2024 +0100
> > 
> > rdma-core-36.10:
> > 
> > Updates from version 36.9
> >  * Backport fixes:
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZFk2B/9eyrpri4YlUMYjNZ8CWgdVGMbykmYDvNou
> > AlJDZqwu9vycAtwisO8kKG7N8OE+xD8QU5QZDrHdxMK5xMXt6Q1yw9utfF3n0vZ3
> > AbmfGiqWFWF/+WLD/HNIrgcfvp7Syq+zpYSNv/phR2VNUkvuy6zBzZYN/5Nw1rUZ
> > Q+LghjKKL5J87BiNVCPnbrCdSE8YpRleDFHUiwyvXY8LNoi+cAtO9nZUufn27hFp
> > BJL8V7J+26rJ9FFEcy/jbDoOKs6t0cAFMYNPJAyYS8ItJ19X8gaxOcwHt2bgztXT
> > 1PWwz5YR1a8oTAeA9Gw3CW4R3u0MmnJC5/OKzM/0Dlw+KXnCV53F
> > =tJch
> > -----END PGP SIGNATURE-----
> > 
> > tag v37.9
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:34 2024 +0100
> > 
> > rdma-core-37.9:
> > 
> > Updates from version 37.8
> >  * Backport fixes:
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZFJRB/90dUmtu0S4ChgTdbEXU7ef6Xzng/TW8vW1
> > FEnwGwyCnIcEJtjPpsDj4D0WGiaZsJY5MTCYAAhx2n6ClCPgZMrMLL9UnMpCFBe3
> > Y52IDvxyuUwqVVzu7yHWrkC3I5g/HJWuaMm8KX8pRGpnfib12sYN4qR6kE0q7Gps
> > akLycBKI8WoPkM1oJCgZPFALiuOX1crscF27h931fDCwpzeDk96nRE7ERR2arCy2
> > LCgxIQ+jBrUW6uH3oq2qgHtxodz5DUYDzqBy8W7QEbBU1Hq9sC0wuDGW0pc+Cvg5
> > fp3XJkKmdm/Re7mG2c4gaMGmDbvFa7q+Le5cgYqtZw5m59u/PINv
> > =D/4m
> > -----END PGP SIGNATURE-----
> > 
> > tag v38.8
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:35 2024 +0100
> > 
> > rdma-core-38.8:
> > 
> > Updates from version 38.7
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZDgyB/kBfCaDaTcL5z3yJB+yGfMo5AeJJTJlZFiv
> > 35v06RV6vIsbkIZpOCVsK72FF1VprabhMuvK2g1/gsSpzEtIG834hH3CKvZbTVnd
> > /ONEQcERVGedHxqHenfma4shcrnUlWL7Us95RrpbRP/sptztq7P6zAHRQHAq6EGY
> > jFclCuuSIO2jDdEBkbZANvcCFUXl6JzpucLEDE0C+D5tQXB20Nhr0dwUUofb8zSv
> > JyqbLONxcHFHzbzt4bXm+2s7CtwMDfBszjpXoeCkHEIADjElY6mhUfcyV4QH6d57
> > U+YCEXwwlJa63wtCjUUmLcDPT3sXVTFrMeaHGZrQhCSLbomaa2GN
> > =H/zh
> > -----END PGP SIGNATURE-----
> > 
> > tag v39.7
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:35 2024 +0100
> > 
> > rdma-core-39.7:
> > 
> > Updates from version 39.6
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZMjnCAC0oXB/dSOx3bpM2hl99C7hsrIfyUxprK7k
> > qgCgOPGNZOOm3jZ8jpijPwGLgwM/CA9TeZmbFuttP1KU+0TOJgrEJehM4hbpAvTD
> > 1wbkk62AkA8GYVUpKEDmSVyCX3cIuvj2w3oxQvqi9FFt68FmLG7Hc5tHQU1IAA08
> > Qx1otLc7dVbmmotKdVyTOhp8eumSc5a564t5kdmE1lVIQqCMw+8kvF0fXT2fr290
> > fhaJY8FwrXkK4nDiK08z7vYGFlRednDBMyxny6Kkxi4n+wS/g6mwq+HOeSFmLBuz
> > 4wPm6WFht2ITMY5btVRTxSu7lDBLgKDyH3dquUwSSqlEI2GaBEXX
> > =eQy6
> > -----END PGP SIGNATURE-----
> > 
> > tag v40.6
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:35 2024 +0100
> > 
> > rdma-core-40.6:
> > 
> > Updates from version 40.5
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZJ7jB/0bBeQbsw7cIwcRmf27IqdORqtf8kvoUFiw
> > dFep16JjJTZ1PDDgDl04aUeeDEhG9VTk5PmuvrbSRC/p/h+9adv8AZGmzJLZfmsz
> > BBGAgQ3gcjaUKh3GZYMSb5056FSjsAWGIa9+0SBV/bExVkZCtIs55hKW1wY951cl
> > dsiQJT7RGftBwrIwKOVq1zWQJnVkDlLg9Ef82pVKv8M5zJKAMs+cVDwLHnpPjE2o
> > RM5nmSSr2vioVy0PQuP9+ck2mnIKT60GryDMuUMSgjyZuvVEId5ISF7UtlC0MNJ2
> > lTg4lJGks389XVDbojWrDfEYzfvNWyEDPI7srMWaNYioZQz+YQPG
> > =z5S1
> > -----END PGP SIGNATURE-----
> > 
> > tag v41.6
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:35 2024 +0100
> > 
> > rdma-core-41.6:
> > 
> > Updates from version 41.5
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZK04B/0Wz8Y8EquLTpfBO91d/lLa4EFMHI3ev8km
> > mBNSIYQnJpcUSgFNJq2IvCHf2x2qX4FOvVknnBqpmgiBwsOwe8K42IVorYcVSOpt
> > ORdhRqPqorRnxEI/c1uOHK+RiKTOIQl2tc1CLeDD1X7PGl6efBAjh7zEaMmj9nhC
> > EXV6eq8jLBvB9svVVrczggWdtTJzaVUViZwpjeOHe44eSTNEdOMuSTB23jBI4NY2
> > A8t+DkcyxVKPs7anlvoLa3AWPtKp/xrs2YZbZcUW/dNgmzojsVgs2KpB7cjXzlUf
> > AXdjspNF0pRON/gqO24ypwNMXCSNBvXz88VZvWqJw2+gzjBfDd+5
> > =tzAg
> > -----END PGP SIGNATURE-----
> > 
> > tag v42.6
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:36 2024 +0100
> > 
> > rdma-core-42.6:
> > 
> > Updates from version 42.5
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZL5FB/9NE1Rk+EQoRCKTEc5TxR99fDPPb7+Jhcvb
> > D5d+PtrggZbGb5qDLLm7Wt07cdYwsmWOzGhmbOQJXvJUW36R+qPPV0atIX8gd0QO
> > 8GBe8ybBLrJrZyeQ9agh8Hh9FRvryrpInruH+LUuFm2Wu5cOiKiroJ2ZkBhtdVOq
> > TWt//ByVG0FdkkOF3dQFTpiXtJj0dNCCSfyycja0ufKZ8Wn6FC+OWhRVvxJ7w+zk
> > RxygZisVHEGveywKFejWMQZ8Gk2XjaJwUIllNszw9meGuGC7QEbXjC0WmSLbAaOe
> > gO2zTKh9rLBZstsa05gfaHpP2/8cDbmhysXv9OrFE2NUuu3oYl5E
> > =aaoI
> > -----END PGP SIGNATURE-----
> > 
> > tag v43.5
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:36 2024 +0100
> > 
> > rdma-core-43.5:
> > 
> > Updates from version 43.4
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZDnRCACeYWyurhRjdQObfVwRe9D4jyRlD5kelgei
> > uA8dkC5iRC5Pj0099+lSkLQp7howArzql5/NZwf2KStifcUfms+6DfTf1iz2KVrP
> > rFaLA52IUi+e9P0i4rT4etS7QjnGq+lJjdT451aP6iI0i3Zt8Od7LMgGDzkSRgAu
> > Y+IQPhYT9bB8NdhaQcvF4zJFTg9wWUqXrDsr/v+YbMiZrkl//NehlTsNYeUEdQKY
> > ZrKd51nwnVfFQ4Yq+k7SiNHgf6+Xg4/aXZBuUHfa87UMPrUFY/NAx4wKSGO3GYbk
> > /E0etODeBx/Zmuv17Sj1lvGuXoataVC6x+rr6HrhTmw9TVGFjczG
> > =3Dac
> > -----END PGP SIGNATURE-----
> > 
> > tag v44.5
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:36 2024 +0100
> > 
> > rdma-core-44.5:
> > 
> > Updates from version 44.4
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZKiWCACjEgkdV5atcQe8AqUMvEhrG5KGU7q824+E
> > 8oRF20yh+5aHOrkotiq40qf6EypY/H0bBe7nhpLG31iqgyoZuSz97Rm7aSc7qi+h
> > CntG+MEoX8Ah0ZMJBll/Wfrg4Ps6W/+3dlRwtoEjbXcYR8g5yqFCQzZ+A21Bn1E8
> > jDrVSWsJgI7CKND8p+3UcW32zjWKGip25g+bvTBI1LFwNbFHZcHrIt6gNfRkV7GH
> > PBLJBvqzkKKcrvQH9CL420dBlP4yVu6vmdnDDD8wasGbRi/GuBFm4Ip67Utwf+Y7
> > 2c/UqXrjuESnVYJRlnetqdJZO02WzqugEG1MAFZDdVp75bcqoET/
> > =Ja8k
> > -----END PGP SIGNATURE-----
> > 
> > tag v45.4
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:37 2024 +0100
> > 
> > rdma-core-45.4:
> > 
> > Updates from version 45.3
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZC2mB/wP07duyCgE7/4n5txuVsREO/Ld1OlbOzsZ
> > /NI28jLRneJCzZDWy041eyMkskPkHTdDrsU2DMO1xQhwzyOhhxsSR0zAa+M4b6FM
> > tav0pjItquQar2/CoBfnJw11+w/0fWgvYiFjRzzjGN9vjKnZBFKTUNrpbRu+wT44
> > 9PHyuDCjx/XKZYCGmA057VQXAYE2KKXvwFmaihfYctJ9IxsKEvR1TO+9QazU35ys
> > sR9r26fuCOt4kGnEV+/+MBK2fHyY30cJm/kfyNK4yvMNSPTRFUv0/f/wkvII6siC
> > cij2a+kFKsbCK5WkiuaxLeUlWIP7vqfhaVEKIX+lJPyEdazNPrl8
> > =mT8B
> > -----END PGP SIGNATURE-----
> > 
> > tag v46.3
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:37 2024 +0100
> > 
> > rdma-core-46.3:
> > 
> > Updates from version 46.2
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * tests: Remove FW reformat check for SW tables
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZNCLCAC3QKML7EHfX9202F2CSYhaTN/1AsuYIKpo
> > UQf9s3rKmu4Fah4G0Cf1sG0jgUL/V0UC6yYCLA4hqY38yoZskC3jRdOGko1wblbK
> > y8AJmong9gIbQUWjDsFw24TLjgcV+DoFb3p719FjfhbuB+wF4oufEnDmkxg0b4Je
> > numgMI6kVwhyf9MPcIKAly1nA69OxLj59KOUwIUIOogJVWvdyLpeFemvEcLyMNi3
> > 6aUvsX3FszboKjE2Ybsp3YOOa8A4rzkoZd7MH1lP8xggBya9+68ZcI68thep+jAB
> > UK3gdE9yKyMq+511gRNgvrJs/5rkVizCXy/WHK3CgZK8pJJQlBds
> > =4lp/
> > -----END PGP SIGNATURE-----
> > 
> > tag v47.2
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:37 2024 +0100
> > 
> > rdma-core-47.2:
> > 
> > Updates from version 47.1
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * mlx5: Add atomic/rdma read for DC comp mask to man page
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * tests: Remove FW reformat check for SW tables
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZNFrCACljv8ZorgaLfpszpmEoIxVDwOpZCLE+FPo
> > fjmTtcegBjOVHXXqQsU6wIHdJJQhu0jfR+4+NEF3CD5k6QBPWgyiEtH+rHaLxwCm
> > Ftm7bC7tuDICUv74b/gvxM/O6P0aGzqS88bTQR8v1m/kT5JZBdrbXxBxIzGGOmBR
> > qicJbHRMF4aeil1z6tfK9T5gB+c23ZAMMcFHBzVpT7zY0OAJ7TcAZqExzk5ATAjx
> > nBDi+A+lN+D+c2nmtzq71CKfY8jG0c5SAl7/lOY4KAt28B8+mBsCbVu/yRoHlD1b
> > Ccl4no/p4OpF3hacfoycAyrueO9ZqZhnXymBqGRb91NPD7buWbpX
> > =t6Qo
> > -----END PGP SIGNATURE-----
> > 
> > tag v48.1
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:37 2024 +0100
> > 
> > rdma-core-48.1:
> > 
> > Updates from version 48.0
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * mlx5: Add atomic/rdma read for DC comp mask to man page
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * tests: Remove FW reformat check for SW tables
> >    * suse: fix issue on non dma-coherent system
> >    * ibtracert: Fix memory leak
> >    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
> >    * /sys/class/infiniband_verbs/uverbs0 is a directory
> >    * stable branch creation
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZDIbB/9ZtEOh3EXYUZHN+X9FkcuQ7QKWIINO3XOz
> > /DeWHHht79OKhfP1pTlcu5Opnd9uMYmQdVJVPsvSj6wb/6Z+FQAOL/deVPgpsm53
> > 9bljctQ8tWwvxq2ppEco1l4QBHdxWuUcP492D0gmFYc/epzScxho8HqwpA8YoR3H
> > Z84CVurNHYYYCfLuUHLjWzCFyoU3c2rbnzoq+HhhzxBMCa3sJDP4Qo7237IcxNec
> > JG0ddVI4LsWP+AubhOmcaYhImpUJgRzhlkD2S8kKCRGO2qXZfVK057h3vb8u9w9r
> > 1un5djWq3swBqA6yjyiJQrDAaF52xEoRhb26J7Q6bCKqXGztqjcp
> > =YBdm
> > -----END PGP SIGNATURE-----
> > 
> > tag v49.1
> > Tagger: Nicolas Morey <nmorey@suse.com>
> > Date:   Mon Jan 22 14:59:38 2024 +0100
> > 
> > rdma-core-49.1:
> > 
> > Updates from version 49.0
> >  * Backport fixes:
> >    * mlx5: DR, Fix ASO CT action applying in cross domain
> >    * mlx5: DR, Fix the default miss vport
> >    * mlx5: DR, Can't go to uplink vport on RX rule
> >    * mlx5: DR, Use the right GVMI number for drop action
> >    * mlx5: DR, Fix pattern compare
> >    * mlx5: Add atomic/rdma read for DC comp mask to man page
> >    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
> >    * libhns: Fix possible overflow in cq clean
> >    * libhns: Fix uninitialized qp attr when flush cqe
> >    * ibnetdisc: Fix leak in add_to_portlid_hash
> >    * stable branch creation
> > -----BEGIN PGP SIGNATURE-----
> > 
> > iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMoQHG5tb3JleUBz
> > dXNlLmNvbQAKCRCAG924JZiPZGmEB/9wYunI9Bw9ecBepSTyPheEY1hu/4H4gGDZ
> > uUAmOLQpgJMeBcAlj/joSbngEbdPEgnTLRk92Vzdno6/456Aoe64mdhS5h1orcrb
> > CLzwpUBqxAzt5++2l2TRSZrywWkci9jQoqBfA4wuF+z6acvpsfyTKq7vblhxJOf0
> > 7uIlzO51hOenEwpGiPeGBJTD/yQD4Q4VRs6LVcPi4ewupAyKYRw1ofL5phPD278P
> > dhmci/Ral7+X4aFkdFCP4z9OQkiksnT/54wFUxUWf55GKIdZ0hXNK345UNU8qxFX
> > 2wvWOr5B+gNxG1NO98PZbWGNR5ty46OovcTJjs/sffPi6JEA5HFW
> > =i2gO
> > -----END PGP SIGNATURE-----
> > 
> > 
> 

