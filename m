Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3C972550F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 09:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbjFGHKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFGHKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 03:10:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B50A1B5
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 00:10:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso58734875e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686121803; x=1688713803;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHsuuU2E9c4UItQzSkAD7VPhH8jiN1PqCJhDJETXiOk=;
        b=K1cJv/Ty925mjljjcTstKTDlHzLuaMnaxB46ZBurtEOOb53k61blmRU11HFashrExl
         QMzVMXKoVfDbHIQyvbuKbsjNVNs69g77MHrBTdTWKzp4WWQ6V6RyCvLM3CnAmkIIcJBw
         cZ8QKgKWzYz0P0ATlwZfdKGHe6FFsif3QXYYBpYhwGfXpgL+LGyodMIye3u1eXhwF0on
         Rgsxe9XXfLdhkWDK17NPJgCMWjRtQ5/gNPVeM60pYu6mOqXMH9ubRtPvbPcM2Ut43PeT
         60/t7jCOwRWkgDSy13dJLlUYY9WkoPC6dRgLUmy6hBtY5qNAK72minG1VXGoNAztpeCk
         hgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121803; x=1688713803;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHsuuU2E9c4UItQzSkAD7VPhH8jiN1PqCJhDJETXiOk=;
        b=Ozoygc56VObjCj5y5riv0zacbyA4Xr/EPGA60qAtJP2rgCYE/H/mkCj5wiYGPCXqA5
         OuXP5QJDuyH+6TeHnrHCOW8ACQLK2qA/ehSkWS5Wk+XTthLpXxwd9WzAQcLIct9bCi6C
         yUWCmv0iwtgB+XeZnKugeh9Pe1IBymnQpg8VQSAIDFc+Tz8NOrXJOevFEwkVwY3qoCvl
         R/G9FSSf9nlyEUgnU5I+n12zejg5yIULrUbcS9EwuoCdNGyo9jOnGizVO1RQYszrBzKn
         XNpxmEsZ9rK1e+XZDWneWTD1A6IZAG/7IIqzDfgtkdWoTeAoe+N/COD/IfEHo2WV0SpH
         2HpA==
X-Gm-Message-State: AC+VfDy/ShdDC4tyGe0hTKPdltTS+lcBGMmb98dBhuPdiOWhz89iOe5H
        v4fYyrJzroLSASi9JzCm8Y8qHw==
X-Google-Smtp-Source: ACHHUZ7v/ydLesR/tgUffvrre3PyqzgnjweTkcEU+YQPXRZTLiQbYBOKuBJseGLCeUhRT0XX5qdnNw==
X-Received: by 2002:a1c:cc0e:0:b0:3f4:fc5e:fbf2 with SMTP id h14-20020a1ccc0e000000b003f4fc5efbf2mr4100706wmb.8.1686121803478;
        Wed, 07 Jun 2023 00:10:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n18-20020a1c7212000000b003f60482024fsm1089097wmc.30.2023.06.07.00.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:10:01 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:09:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     paulb@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: TC, Set CT miss to the specific ct action
 instance
Message-ID: <497f5a7a-9f14-478e-b551-1fa74720b6f8@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Paul Blakey,

The patch 6702782845a5: "net/mlx5e: TC, Set CT miss to the specific
ct action instance" from Feb 18, 2023, leads to the following Smatch
static checker warning:

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:5648 mlx5e_tc_action_miss_mapping_get() warn: missing error code 'err'

Let's include some older unpublished Smatch stuff as well.

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1683 mlx5e_tc_query_route_vport() info: return a literal instead of 'err'
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:4786 mlx5e_stats_flower() warn: missing error code 'err'

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
  1665  int mlx5e_tc_query_route_vport(struct net_device *out_dev, struct net_device *route_dev, u16 *vport)
  1666  {
  1667          struct mlx5e_priv *out_priv, *route_priv;
  1668          struct mlx5_core_dev *route_mdev;
  1669          struct mlx5_devcom *devcom;
  1670          struct mlx5_eswitch *esw;
  1671          u16 vhca_id;
  1672          int err;
  1673          int i;
  1674  
  1675          out_priv = netdev_priv(out_dev);
  1676          esw = out_priv->mdev->priv.eswitch;
  1677          route_priv = netdev_priv(route_dev);
  1678          route_mdev = route_priv->mdev;
  1679  
  1680          vhca_id = MLX5_CAP_GEN(route_mdev, vhca_id);
  1681          err = mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport);
  1682          if (!err)
  1683                  return err;

This seems intentional but it look more intentional as "return 0;"

  1684  
  1685          if (!mlx5_lag_is_active(out_priv->mdev))
  1686                  return err;

return -ENOENT; here?

  1687  
  1688          rcu_read_lock();
  1689          devcom = out_priv->mdev->priv.devcom;
  1690          err = -ENODEV;
  1691          mlx5_devcom_for_each_peer_entry_rcu(devcom, MLX5_DEVCOM_ESW_OFFLOADS,
  1692                                              esw, i) {
  1693                  err = mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport);
  1694                  if (!err)
  1695                          break;
  1696          }
  1697          rcu_read_unlock();
  1698  
  1699          return err;
  1700  }

[ snip ]

  4727  int mlx5e_stats_flower(struct net_device *dev, struct mlx5e_priv *priv,
  4728                         struct flow_cls_offload *f, unsigned long flags)
  4729  {
  4730          struct mlx5_devcom *devcom = priv->mdev->priv.devcom;
  4731          struct rhashtable *tc_ht = get_tc_ht(priv, flags);
  4732          struct mlx5e_tc_flow *flow;
  4733          struct mlx5_fc *counter;
  4734          u64 lastuse = 0;
  4735          u64 packets = 0;
  4736          u64 bytes = 0;
  4737          int err = 0;
  4738  
  4739          rcu_read_lock();
  4740          flow = mlx5e_flow_get(rhashtable_lookup(tc_ht, &f->cookie,
  4741                                                  tc_ht_params));
  4742          rcu_read_unlock();
  4743          if (IS_ERR(flow))
  4744                  return PTR_ERR(flow);
  4745  
  4746          if (!same_flow_direction(flow, flags)) {
  4747                  err = -EINVAL;
  4748                  goto errout;
  4749          }
  4750  
  4751          if (mlx5e_is_offloaded_flow(flow)) {
  4752                  if (flow_flag_test(flow, USE_ACT_STATS)) {
  4753                          f->use_act_stats = true;
  4754                  } else {
  4755                          counter = mlx5e_tc_get_counter(flow);
  4756                          if (!counter)
  4757                                  goto errout;

No error code.  In this function it's hard to say if these should be
error paths or not.

  4758  
  4759                          mlx5_fc_query_cached(counter, &bytes, &packets, &lastuse);
  4760                  }
  4761          }
  4762  
  4763          /* Under multipath it's possible for one rule to be currently
  4764           * un-offloaded while the other rule is offloaded.
  4765           */
  4766          if (!mlx5_devcom_for_each_peer_begin(devcom, MLX5_DEVCOM_ESW_OFFLOADS))
  4767                  goto out;

No error code

  4768  
  4769          if (flow_flag_test(flow, DUP)) {
  4770                  struct mlx5e_tc_flow *peer_flow;
  4771  
  4772                  list_for_each_entry(peer_flow, &flow->peer_flows, peer_flows) {
  4773                          u64 packets2;
  4774                          u64 lastuse2;
  4775                          u64 bytes2;
  4776  
  4777                          if (!flow_flag_test(peer_flow, OFFLOADED))
  4778                                  continue;
  4779                          if (flow_flag_test(flow, USE_ACT_STATS)) {
  4780                                  f->use_act_stats = true;
  4781                                  break;
  4782                          }
  4783  
  4784                          counter = mlx5e_tc_get_counter(peer_flow);
  4785                          if (!counter)
  4786                                  goto no_peer_counter;

No error code

  4787                          mlx5_fc_query_cached(counter, &bytes2, &packets2,
  4788                                               &lastuse2);
  4789  
  4790                          bytes += bytes2;
  4791                          packets += packets2;
  4792                          lastuse = max_t(u64, lastuse, lastuse2);
  4793                  }
  4794          }
  4795  
  4796  no_peer_counter:
  4797          mlx5_devcom_for_each_peer_end(devcom, MLX5_DEVCOM_ESW_OFFLOADS);
  4798  out:
  4799          flow_stats_update(&f->stats, bytes, packets, 0, lastuse,
  4800                            FLOW_ACTION_HW_STATS_DELAYED);
  4801          trace_mlx5e_stats_flower(f);
  4802  errout:
  4803          mlx5e_flow_put(priv, flow);
  4804          return err;
  4805  }

[ snip ]

  5627  int mlx5e_tc_action_miss_mapping_get(struct mlx5e_priv *priv, struct mlx5_flow_attr *attr,
  5628                                       u64 act_miss_cookie, u32 *act_miss_mapping)
  5629  {
  5630          struct mlx5_mapped_obj mapped_obj = {};
  5631          struct mlx5_eswitch *esw;
  5632          struct mapping_ctx *ctx;
  5633          int err;
  5634  
  5635          ctx = mlx5e_get_priv_obj_mapping(priv);
  5636          mapped_obj.type = MLX5_MAPPED_OBJ_ACT_MISS;
  5637          mapped_obj.act_miss_cookie = act_miss_cookie;
  5638          err = mapping_add(ctx, &mapped_obj, act_miss_mapping);
  5639          if (err)
  5640                  return err;
  5641  
  5642          if (!is_mdev_switchdev_mode(priv->mdev))
  5643                  return 0;
  5644  
  5645          esw = priv->mdev->priv.eswitch;
  5646          attr->act_id_restore_rule = esw_add_restore_rule(esw, *act_miss_mapping);
  5647          if (IS_ERR(attr->act_id_restore_rule))
  5648                  goto err_rule;

This one is definitely an error path.

  5649  
  5650          return 0;
  5651  
  5652  err_rule:
  5653          mapping_remove(ctx, *act_miss_mapping);
  5654          return err;
  5655  }

regards,
dan carpenter
